require './index.styl'
require '../index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
DoughnutChart = react.createFactory (require 'react-chartjs-2' .Doughnut)
{div} = react.DOM


class Politics extends react.Component

  render: ~>
    div className: 'c-politics',
      div className: 'metric-title', 'Political Leaning'
      DoughnutChart {
        className: 'chart'
        data:
          labels: @props.data.map (politicsInfo) -> politicsInfo.political_leaning
          datasets: [
            data: @props.data.map (politicsInfo) -> politicsInfo.score * 100
            backgroundColor: <[#FF5254 #36A2EB #C44D58 #8CD19D #FCB653]>
            hoverBackgroundColor: <[#FF5254 #36A2EB #C44D58 #8CD19D #FCB653]>
          ]
      }


module.exports = Politics
