require './index.styl'
react = require 'react'
{div, span} = react.DOM

class Message extends react.Component
  render: ~>
    div className: 'c-message', onClick: @props.onClick,
      div className: 'avatar'
      div className: 'message-summary',
        span className: 'name', @props.message.recipient
        span className: 'time', @props.message.time
        div className: 'summary', @props.message.summary


module.exports = Message
