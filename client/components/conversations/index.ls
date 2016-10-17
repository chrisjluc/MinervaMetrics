require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{button, div, input} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
MessageFrequency = react.createFactory require '../metrics/message_frequency'
FrequentTopics = react.createFactory require '../metrics/frequent_topics'
Conversation = react.createFactory require './conversation'
request = require 'request'


class Conversations extends react.Component
  
  ->
    @state = 
      conversations: []
      selectedConvo: -1
      metrics: {}
    setTimeout (~> @getConversations!), 1000


  getConversations: ~>
    options =
      url: "http://127.0.0.1:8000/api/conversations?user_id=1"#{@props.params.userId}"
      withCredentials: false
    request options, (err, resp, body) ~>
      conversations = JSON.parse body
      conversations.map (conversation) ~>
        convoOptions =
          url: "http://127.0.0.1:8000/api/conversation-data?conversation_id=#{conversation.conversation_id}"
          withCredentials: false
        request convoOptions, (cErr, cResp, cBody) ~>
          convo = JSON.parse cBody
          convo.conversation_id = conversation.conversation_id
          prevConvos = @state.conversations
          prevConvos.push convo
          @setState conversations: prevConvos


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


  selectConvo: (i) ~>
    @setState selectedConvo: i 


  analyze: (i) ~>
    @getTopWords i
    @getMessageFreq i


  render: ->
    div className: 'c-conversations',
      div className: 'conversations-tab',
        div className: 'search',
          input placeholder: 'Search for conversations'
        @state.conversations.map (conversation, i) ~>
          Conversation {
            key: i
            conversation: conversation
            onClick: ~> @selectConvo conversation.conversation_id
          }

      div className: 'analytics-pane',
        if @state.selectedConvo == -1
          div className: 'select-a-convo', 'Select a conversation to get started!'
        else if !@state.metrics[@state.selectedConvo]
          button className: 'analyze-button', onClick: (~> @analyze @state.selectedConvo),
            'Analyze!'
        else
          div {},
            if @state.metrics[@state.selectedConvo].mostFrequentWords
              MostFrequentWords mostFrequentWords: @state.metrics[@state.selectedConvo].mostFrequentWords
            if @state.metrics[@state.selectedConvo].messageFrequency
              MessageFrequency messageFrequency: @state.metrics[@state.selectedConvo].messageFrequency
              # FrequentTopics {}


module.exports = Conversations
