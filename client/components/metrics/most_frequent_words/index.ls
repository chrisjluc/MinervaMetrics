require './index.styl'
require '../index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
BarChart = react.createFactory (require 'react-chartjs-2' .HorizontalBar)
{div} = react.DOM


class MostFrequentWords extends react.Component

  render: ~>
    div className: 'c-most-freq-words',
      div className: 'metric-title', 'Most Frequent Words'
      BarChart {
        className: 'chart'
        data:
          labels: @props.data.slice(0,10).map (wordInfo) -> wordInfo.word
          datasets: [
            * label: 'Word Count'
              data: @props.data.slice(0,10).map (wordInfo) -> wordInfo.count
              backgroundColor: 'rgba(0,132,255, 0.4)'
              borderColor: 'rgba(0,132,255, 0.4)'
              hoverBackgroundColor: 'rgba(0,132,255, 0.8)'
          ]
        options:
          scales:
            xAxes: [
              ticks:
                min: 0
            ]
      }


module.exports = MostFrequentWords
