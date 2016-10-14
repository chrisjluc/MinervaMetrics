require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{div} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'


class Messages extends react.Component
  
  ->
    @state = 
      messages: testMsgs
      selectedConvo: -1

  # getMetrics: ->
  #   @setState mostFrequentWords:

  render: ->
    div className: 'c-messages',
      div className: 'messages-tab',
        @state.messages.map (message, i) ~>
          div {
            className: 'message'
            key: i
            onClick: ~>
              @setState selectedConvo: i
          }, message.summary 

      div className: 'analytics-pane',
        if @state.selectedConvo == -1
          div className: 'select-a-convo', 'Select a conversation to get started!'
        else
          div {},
            MostFrequentWords {}

  testMsgs = [
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
    {
      recipient: 'Bob'
      summary: 'Hi Bob how are you doing...'
    }
  ]


module.exports = Messages
