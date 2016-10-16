require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{button, div, input} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
Conversation = react.createFactory require './conversation'


class Conversations extends react.Component
  
  ->
    @state = 
      conversations: testMsgs
      selectedConvo: -1
      metrics: {}


  selectConvo: (i) ~>
    @setState selectedConvo: i 
    

  analyze: (i) ~>
    metrics = @state.metrics
    metrics[i] =
      mostFrequentWords:
        * word: 'hello'
          count: 10
        * word: 'world'
          count: 5
      # otherMetric: {}
    @setState metrics: metrics


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
          MostFrequentWords mostFrequentWords: @state.metrics[@state.selectedConvo].mostFrequentWords

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
