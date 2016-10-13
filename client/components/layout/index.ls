require './index.styl'
react = require 'react'
{div} = react.DOM
Header = react.createFactory require '../header'


module.exports = (props) ->
  div className: 'c-layout',
    Header {}
    div className: 'layout-content', props.children
