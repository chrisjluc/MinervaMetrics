require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{div, input} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
Message = react.createFactory require './message'


class Messages extends react.Component
  
  ->
    @state = 
      messages: testMsgs
      selectedConvo: -1

  # getMetrics: ->
  #   @setState mostFrequentWords:

  selectConvo: (i) ~>
    @setState selectedConvo: i 

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
        else
          div {},
            MostFrequentWords {}

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
