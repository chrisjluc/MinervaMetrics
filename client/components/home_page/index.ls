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
          Description of our product
          '''
      button {onClick: -> browserHistory.push '/messages'}, 'Log in with Facebook'


module.exports = HomePage
