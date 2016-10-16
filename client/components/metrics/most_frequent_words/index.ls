require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
# Metric = require './'
{div, table, tbody, td, tr} = react.DOM


class MostFrequentWords extends react.Component

  render: ~>
    div className: 'c-most-freq-words',
      div className: 'metric-title', 'Most Frequent Words'
      table className: 'words-table',
        console.log JSON.stringify @props.mostFrequentWords
        @props.mostFrequentWords.map (wordInfo, i) ->
          tbody key: i,
            tr {},
              td {}, wordInfo.word
              td {}, wordInfo.count



module.exports = MostFrequentWords
