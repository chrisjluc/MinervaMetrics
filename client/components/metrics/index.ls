require './index.styl'
react = require 'react'
{div} = react.DOM

class Metric extends react.Component
  render: ->
    div className: 'c-metric', 'hello'


module.exports = Metric
