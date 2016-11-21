require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{button, div, input} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
MessageFrequency = react.createFactory require '../metrics/message_frequency'
FrequentTopics = react.createFactory require '../metrics/frequent_topics'
Emotions = react.createFactory require '../metrics/emotions'
Politics = react.createFactory require '../metrics/politics'
Conversation = react.createFactory require './conversation'
request = require 'request'


class Conversations extends react.Component

  ->
    @state =
      conversations: []
      selectedConvo: -1
      currentConvo: {}
      metrics: {}
      mostFrequentWords: {}
      messageFrequency: {}
      emotions: {}
      topics: {}
      politics: {}
      userId: -1
      apiKey: ''


  getUserId: (t) ~>
    console.log 'getting user id'
    options =
      url: "https://graph.facebook.com/v2.3/me?access_token=#{t}"
      withCredentials: false
    request options, (err, resp, body) ~>
      console.log 'FB resp: '
      console.log body
      console.log "id: #{JSON.parse(body).id}"
      @setState userId: JSON.parse(body).id
      setTimeout (~> @getConversations!), 1000


  sendAuthToken: (t) ~>
    @setState apiKey: t
    console.log "sending auth token #{t}"
    options =
      method: 'POST'
      url: 'http://127.0.0.1:8000/api/parse/'
      body: JSON.stringify token: t
      headers:
        "Content-Type": "application/json"
      withCredentials: false

    request options, (err, resp, body) ->
    @getUserId t


  getConversations: ~>
    console.log "getting convos for #{@state.userId}"
    if @state.userId is -1
      return
    options =
      url: "http://127.0.0.1:8000/api/conversations?user_id=#{@state.userId}"
      withCredentials: false
    request options, (err, resp, body) ~>
      conversations = JSON.parse body
      @setState conversations: conversations


  getTopWords: (i) ~>
    options =
      url: "http://127.0.0.1:8000/api/analytics/top-words?conversation_id=#{i}"
      withCredentials: false
    request options, (err, resp, body) ~>
      metrics = @state.metrics
      if metrics[i]
        metrics[i].mostFrequentWords = JSON.parse body
      else
        metrics[i] =
          mostFrequentWords: JSON.parse body
      @setState metrics: metrics


  getMessageFreq: (i) ~>
    options =
      url: "http://127.0.0.1:8000/api/analytics/message-count?conversation_id=#{i}&period=month"
      withCredentials: false
    request options, (err, resp, body) ~>
      metrics = @state.metrics
      if metrics[i]
        metrics[i].messageFrequency = JSON.parse body
      else
        metrics[i] =
          messageFrequency: JSON.parse body
      @setState metrics: metrics


  getEmotions: (i) ~>
    options =
      url: "http://127.0.0.1:8000/api/analytics/emotions?conversation_id=#{i}"
      withCredentials: false
    request options, (err, resp, body) ~>
      metrics = @state.metrics
      if metrics[i]
        metrics[i].emotions = JSON.parse body
      else
        metrics[i] =
          emotions: JSON.parse body
      @setState metrics: metrics


  getTopics: (i) ~>
    options =
      url: "http://127.0.0.1:8000/api/analytics/topics?conversation_id=#{i}"
      withCredentials: false
    request options, (err, resp, body) ~>
      metrics = @state.metrics
      if metrics[i]
        metrics[i].topics = JSON.parse body
      else
        metrics[i] =
          topics: JSON.parse body
      @setState metrics: metrics


  getPolitics: (i) ~>
    options =
      url: "http://127.0.0.1:8000/api/analytics/political-leanings?conversation_id=#{i}"
      withCredentials: false
    request options, (err, resp, body) ~>
      metrics = @state.metrics
      if metrics[i]
        metrics[i].politics = JSON.parse body
      else
        metrics[i] =
          politics: JSON.parse body
      @setState metrics: metrics


  selectConvo: (i) ~>
    # @analyze i
    @setState selectedConvo: i
    for convo in @state.conversations
      if convo.conversation_id is i
        @setState currentConvo: convo


  analyze: (i) ~>
    console.log "analyzing convo #{i}"
    options =
      url: 'http://127.0.0.1:8000/api/parseMessages/'
      withCredentials: false
      method: 'POST'
      body: JSON.stringify token: @state.apiKey, conversationId: i
      headers:
        "Content-Type": "application/json"
    request options, (err, resp, body) ->
    setTimeout (~> @getTopWords i), 1000
    setTimeout (~> @getMessageFreq i), 1000
    setTimeout (~> @getEmotions i), 1000
    setTimeout (~> @getTopics i), 1000
    setTimeout (~> @getPolitics i), 1000


  parse: (k) ~>
    if k.keyCode is 13 then @sendAuthToken @refs.msgAPIkey.value


  render: ~>
    div className: 'c-conversations',
      div className: 'conversations-tab', style: { borderRight: "#{if @state.selectedConvo != -1 then 'none' else '1px solid #b2b2b2'}" },
        div className: 'search',
          input placeholder: 'Search for conversations'
        @state.conversations.map (conversation, i) ~>
          Conversation {
            key: i
            conversation: conversation
            userId: @state.userId
            onClick: ~> @selectConvo conversation.conversation_id
          }

      div className: 'analytics-pane',
        if @state.selectedConvo == -1
          div {},
            div className: 'select-a-convo', 'Select a conversation to get started!'
            input placeholder: 'Or manually import your FB message key here', onKeyDown: @parse, ref: 'msgAPIkey'
        else if !@state.metrics[@state.selectedConvo]
          div {},
            div className: 'conversation-title',
              'Conversation between ' + @state.currentConvo.participants.map (p, i) ~> " #{p.name}"
            button className: 'analyze-button', onClick: (~> @analyze @state.selectedConvo),
              'Analyze!'
        else
          div {},
            div className: 'conversation-title',
              'Conversation with ' + @state.currentConvo.participants.map (p, i) ~> " #{p.name}"
            button {className: 'refresh-messages', onClick: ~> @analyze @state.selectedConvo},
              'Refresh Analytics'
            if Object.keys(@state.metrics[@state.selectedConvo].mostFrequentWords).length > 0
              MostFrequentWords data: @state.metrics[@state.selectedConvo].mostFrequentWords
            if Object.keys(@state.metrics[@state.selectedConvo].messageFrequency).length > 0
              MessageFrequency data: @state.metrics[@state.selectedConvo].messageFrequency
            if Object.keys(@state.metrics[@state.selectedConvo].emotions).length > 0
              Emotions data: @state.metrics[@state.selectedConvo].emotions
            if Object.keys(@state.metrics[@state.selectedConvo].politics).length > 0
              Politics data: @state.metrics[@state.selectedConvo].politics
            if Object.keys(@state.metrics[@state.selectedConvo].topics).length > 0
              FrequentTopics data: @state.metrics[@state.selectedConvo].topics
            # if Object.keys(@state.metrics[@state.selectedConvo].mostTalkative).length > 0
            #   MostTalkative data: @state.metrics[@state.selectedConvo].mostTalkative



module.exports = Conversations
