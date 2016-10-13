require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{button, div} = react.DOM


class HomePage extends react.Component

  render: ->
    div className: 'c-home-page',
      div className: 'description',
        '''
        Description of our product
        '''
      button {}, 'Log in with Facebook'


module.exports = HomePage
