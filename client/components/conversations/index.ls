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
      console.log conversations
      convos = []
      conversations.map (conversation) ~>
        participantsOptions =
          url: "http://127.0.0.1:8000/api/participants?conversation_id=#{conversation.conversation_id}"
          withCredentials: false
        request participantsOptions, (participantsErr, participantsResp, participantsBody) ~>
          participants = JSON.parse participantsBody
          console.log participants
          convo =
            recipients: []
            # time:
          participants.forEach (participants) ->
            convo.recipients.push participants.user_id
          prevConvos = @state.conversations
          prevConvos.push convo
          @setState conversations: prevConvos


  getTopWords: (i) ~>
    options =
      url: "http://127.0.0.1:8000/api/analytics/top-words?conversation_id=#{i}"
      withCredentials: false
    request options, (err, resp, body) ~>
      metrics = @state.metrics
      console.log body
      metrics[i] = 
        mostFrequentWords: JSON.parse body
        
      @setState metrics: metrics


  selectConvo: (i) ~>
    @setState selectedConvo: i 


  analyze: (i) ~>
    @getTopWords i


  render: ->
    div className: 'c-conversations',
      div className: 'conversations-tab',
        div className: 'search',
          input placeholder: 'Search for conversations'
        @state.conversations.map (conversation, i) ~>
          Conversation {
            key: i
            conversation: conversation
            onClick: ~> @selectConvo i
          }

      div className: 'analytics-pane',
        if @state.selectedConvo == -1
          div className: 'select-a-convo', 'Select a conversation to get started!'
        else if !@state.metrics[@state.selectedConvo]
          button className: 'analyze-button', onClick: (~> @analyze @state.selectedConvo),
            'Analyze!'
        else
          div {},
            MostFrequentWords mostFrequentWords: @state.metrics[@state.selectedConvo].mostFrequentWords
            MessageFrequency {}
            FrequentTopics {}

  testMsgs = [
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
    {
      recipient: 'Alice'
      summary: 'Hi Alice how are you doing...'
      time: '9:00pm'
    }
  ]


module.exports = Conversations
