require './index.styl'
react = require 'react'
{div, span} = react.DOM

class Conversation extends react.Component
  render: ~>
    date = new Date @props.conversation.latest_time 
    div className: 'c-conversation', onClick: @props.onClick,
      div className: 'avatar'
      div className: 'conversation-summary',
        span className: 'name', @props.conversation.participants.map (p, i) ~> "#{p.name}#{if i < @props.conversation.participants.length-1 then ', ' else ''}"
        span className: 'time', "#{date.getMonth!}-#{date.getDate!}-#{date.getFullYear!} at #{date.getHours!}:#{date.getMinutes!}"
        div className: 'summary', "#{@props.conversation.count} messages"


module.exports = Conversation
