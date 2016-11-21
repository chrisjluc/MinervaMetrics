require './index.styl'
require '../index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
DoughnutChart = react.createFactory (require 'react-chartjs-2' .Doughnut)
{div} = react.DOM


class Emotions extends react.Component

  render: ~>
    div className: 'c-emotions',
      div className: 'metric-title', 'Emotions'
      DoughnutChart {
        className: 'chart'
        data:
          labels: @props.data.map (emotionInfo) -> emotionInfo.emotion
          datasets: [
            data: @props.data.map (emotionInfo) -> emotionInfo.score * 100
            backgroundColor: <[#FF5254 #36A2EB #C44D58 #8CD19D #FCB653]>
            hoverBackgroundColor: <[#FF5254 #36A2EB #C44D58 #8CD19D #FCB653]>
          ]
      }


module.exports = Emotions
