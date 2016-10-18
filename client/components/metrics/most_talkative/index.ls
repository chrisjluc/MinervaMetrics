require './index.styl'
require '../index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
PieChart = react.createFactory (require 'react-chartjs-2' .Pie)
{div} = react.DOM


class MostTalkative extends react.Component

  render: ~>
    div className: 'c-most-talkative',
      div className: 'metric-title', 'Most Talkative'
      PieChart {
        className: 'chart'
        data:
          labels: <[Alice Bob Eve]>
          datasets: [
            data: [300 50 100]
            backgroundColor: <[#FF6B6B #36A2EB #FCB653]>
            hoverBackgroundColor: <[#FF6B6B #36A2EB #FCB653]>
          ]
      }

module.exports = MostTalkative
