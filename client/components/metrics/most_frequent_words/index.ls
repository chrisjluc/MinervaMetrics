require './index.styl'
require '../index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
BarChart = react.createFactory (require 'react-chartjs-2' .Bar)
{div} = react.DOM


class MostFrequentWords extends react.Component

  render: ~>
    div className: 'c-most-freq-words',
      div className: 'metric-title', 'Most Frequent Words'
      BarChart {
        className: 'chart'
        data:
          labels: @props.mostFrequentWords.map (wordInfo) -> wordInfo.word
          datasets: [
            * label: 'Word Count'
              data: @props.mostFrequentWords.map (wordInfo) -> wordInfo.count
              backgroundColor: '#0084ff'
          ]
      }


module.exports = MostFrequentWords
