require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
{div} = react.DOM


class Header extends react.Component

  render: ->
    div className: 'c-header',
      div {className: 'name', onClick: -> browserHistory.push '/'}, 'Minerva Metrics'


module.exports = Header
