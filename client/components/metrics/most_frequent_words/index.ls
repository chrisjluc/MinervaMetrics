require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
# Metric = require './'
{div, table, tr} = react.DOM


class MostFrequentWords extends react.Component

  render: ->
    div className: 'c-most-freq-words',
      div className: 'metric-title', 'Most Frequent Words'
      table className: 'words-table',
        tr {}, 
          'hello'
          'world'
        tr {}, 'hello'



module.exports = MostFrequentWords
