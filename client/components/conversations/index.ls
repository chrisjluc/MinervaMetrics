require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{button, div, h1, input} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
MessageFrequency = react.createFactory require '../metrics/message_frequency'
FrequentTopics = react.createFactory require '../metrics/frequent_topics'
Emotions = react.createFactory require '../metrics/emotions'
Politics = react.createFactory require '../metrics/politics'
Conversation = react.createFactory require './conversation'
Promise = require 'bluebird'
request = require 'request'
ModalContainer = react.createFactory (require 'react-modal-dialog' .ModalContainer)
ModalDialog = react.createFactory (require 'react-modal-dialog' .ModalDialog)
Spinner = react.createFactory require 'react-spinjs'

apiEndpoint = 'http://localhost:8000/api/'
analyticsEndpoint = 'http://localhost:8000/api/analytics/'
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
      showModal: true
      loading: false


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
      url: "#{apiEndpoint}parse/"
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
      url: "#{apiEndpoint}conversations?user_id=#{@state.userId}"
      withCredentials: false
    request options, (err, resp, body) ~>
      conversations = JSON.parse body
      @setState conversations: conversations, loading: false


  getTopWords: (i) ~>
    options =
      url: "#{analyticsEndpoint}top-words?conversation_id=#{i}"
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
      url: "#{analyticsEndpoint}message-count?conversation_id=#{i}&period=month"
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
      url: "#{analyticsEndpoint}emotions?conversation_id=#{i}"
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
      url: "#{analyticsEndpoint}topics?conversation_id=#{i}"
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
      url: "#{analyticsEndpoint}political-leanings?conversation_id=#{i}"
      withCredentials: false
    request options, (err, resp, body) ~>
      metrics = @state.metrics
      if metrics[i]
        metrics[i].politics = JSON.parse body
      else
        metrics[i] =
          politics: JSON.parse body
      @setState metrics: metrics, loading: false


  selectConvo: (i) ~>
    @setState selectedConvo: i
    for convo in @state.conversations
      if convo.conversation_id is i
        @setState currentConvo: convo
    @analyze i unless @state.metrics[i]


  updateMessages: (i) ~>
    @setState loading: true
    console.log "analyzing convo #{i}"
    options =
      url: apiEndpoint + 'parseMessages/'
      withCredentials: false
      method: 'POST'
      body: JSON.stringify token: @state.apiKey, conversationId: i
      headers:
        "Content-Type": "application/json"
    request options, (err, resp, body) ->
    setTimeout (~> @getConversations!), 1000
    @analyze i


  analyze: (i) ~>
    @setState loading: true
    setTimeout (~> @getTopWords i), 1000
    setTimeout (~> @getMessageFreq i), 1000
    setTimeout (~> @getEmotions i), 1000
    setTimeout (~> @getTopics i), 1000
    setTimeout (~> @getPolitics i), 1000


  parse: (k) ~>
    if k.keyCode is 13
      @setState loading: true, showModal: false
      @sendAuthToken @refs.msgAPIkey2.value


  handleClose: ~>
    @setState showModal: false


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
        if @state.loading
          ModalContainer {onClose: ~> @setState showModal: false},
            Spinner {}
        if @state.showModal
          ModalContainer {onClose: ~> @setState showModal: false},
            ModalDialog {onClose: ~> @setState showModal: false},
              h1 {
                style: {
                  fontFamily: 'sans-serif'
                  textAlign: 'center'
                }
                onClick: -> window.open 'https://developers.facebook.com/tools/explorer/?version=v2.3'
              }, 'Click here to get your API key!'

              input {
                placeholder: 'Paste your FB Graph API key'
                onKeyDown: @parse, ref: 'msgAPIkey2'
                style: {
                  backgroundColor: '#f6f7f9'
                  borderRadius: '3px'
                  borderStyle: 'none'
                  fontSize: '14px'
                  height: '24px'
                  lineHeight: '24px'
                  padding: '0 28px'
                  outline: 'none'
                  marginTop: '8px'
                  width: '1000px'
                  maxWidth: '500px'
                  boxSizing: 'border-box'
                  textAlign: 'center'
                  # &:focus::-webkit-input-placeholder
                  #   color: transparent
                }
              }
        if @state.selectedConvo == -1
          div {},
            div className: 'select-a-convo', 'Select a conversation from the left or paste your Facebook Graph API key below to get started!'
            button {className: 'insert-key-button', onClick: ~> @setState showModal: true}, 'Input API key'
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
            button {className: 'refresh-messages', onClick: ~> @updateMessages @state.selectedConvo},
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
