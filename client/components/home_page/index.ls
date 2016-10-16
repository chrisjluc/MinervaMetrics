require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{button, div, p} = react.DOM


class HomePage extends react.Component

  render: ->
    div className: 'c-home-page',
      div className: 'description',
        p {},
          '''
          Analyze your Facebook messages
          '''
      button {onClick: -> browserHistory.push '/conversations'}, 'Log in with Facebook'


module.exports = HomePage
