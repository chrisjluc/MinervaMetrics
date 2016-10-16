require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{button, div, input} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
Message = react.createFactory require './message'


class Messages extends react.Component
  
  ->
    @state = 
      messages: testMsgs
      selectedConvo: -1
      metrics: {}

  # getMetrics: ->
  #   @setState mostFrequentWords:

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
    div className: 'c-messages',
      div className: 'messages-tab',
        div className: 'search',
          input placeholder: 'Search for conversations'
        @state.messages.map (message, i) ~>
          Message {
            key: i
            message: message
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


module.exports = Messages
