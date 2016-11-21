require './index.styl'
react = require 'react'
{div, span} = react.DOM

class Conversation extends react.Component
  render: ~>
    dirty = @props.conversation.count is '0' or @props.conversation.has_updates
    excludingMe = @props.conversation.participants.filter (p, i) ~>
      p.user_id is not @props.userId

    if excludingMe.length is 0 then return div {}

    date = new Date @props.conversation.latest_time
    div className: 'c-conversation', onClick: @props.onClick,
      div className: 'avatar', style: backgroundImage: "url(\"http://graph.facebook.com/#{excludingMe[0].user_id}/picture?type=square\")"
      div className: 'conversation-summary',
        span className: 'name',
          if excludingMe.length > 1
            "#{excludingMe[0].name} + #{@props.conversation.participants.length-1} more"
          else
            "#{excludingMe[0].name}"
        span className: 'time', "#{date.getMonth!}-#{date.getDate!}-#{date.getFullYear!} at #{date.getHours!}:#{date.getMinutes!}"
        div {
          className: 'summary',
          style: {
            color: "#{if dirty then '#0084ff' else '#999999'}"
          }
        },
          if dirty
            'New Messages!'
          else
            "#{@props.conversation.count} messages"


module.exports = Conversation
