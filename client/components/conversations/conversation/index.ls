require './index.styl'
react = require 'react'
{div, span} = react.DOM

class Conversation extends react.Component
  render: ~>
    div className: 'c-conversation', onClick: @props.onClick,
      div className: 'avatar'
      div className: 'conversation-summary',
        span className: 'name', @props.conversation.recipient
        span className: 'time', @props.conversation.time
        div className: 'summary', @props.conversation.summary


module.exports = Conversation
