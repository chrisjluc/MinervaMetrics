require './index.styl'
react = require 'react'
{div, span} = react.DOM

class Conversation extends react.Component
  render: ~>
    date = new Date @props.conversation.latest_time
    div className: 'c-conversation', onClick: @props.onClick,
      div className: 'avatar', style: backgroundImage: "url(\"http://graph.facebook.com/#{@props.conversation.participants[0].user_id}/picture?type=square\")"
        # @props.conversation.participants[0].name[0]
      div className: 'conversation-summary',
        span className: 'name',
          if @props.conversation.participants.length > 1
            "#{@props.conversation.participants[0].name} + #{@props.conversation.participants.length-1} more"
          else
            "#{@props.conversation.participants[0].name}"
        span className: 'time', "#{date.getMonth!}-#{date.getDate!}-#{date.getFullYear!} at #{date.getHours!}:#{date.getMinutes!}"
        div className: 'summary', "#{@props.conversation.count} messages"


module.exports = Conversation
