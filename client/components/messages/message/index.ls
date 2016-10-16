require './index.styl'
react = require 'react'
{div} = react.DOM

class Message extends react.Component
  render: ~>
    div className: 'c-message', onClick: @props.onClick,
      div className: 'avatar'
      div className: 'message-summary',
        div className: 'name', @props.message.recipient
        div className: 'summary', @props.message.summary



module.exports = Message
