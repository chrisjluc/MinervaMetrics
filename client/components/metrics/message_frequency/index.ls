require './index.styl'
require '../index.styl'
react = require 'react'
{div} = react.DOM
LineChart = react.createFactory (require 'react-chartjs-2' .Line)

class MessageFrequency extends react.Component
  render: ->
    div className: 'c-messages-freq',
      div className: 'metric-title', 'Message Frequency'
      LineChart {
        className: 'chart'
        data:
          labels: <[January February March April May June July]>
          datasets: [
            * label: '# Messages'
              fill: false
              lineTension: 0.1
              backgroundColor: '#0084ff'
              borderColor: '#0084ff'
              borderCapStyle: 'butt'
              borderDash: []
              borderDashOffset: 0.0
              borderJoinStyle: 'miter'
              pointBorderColor: '#0084ff'
              pointBackgroundColor: '#fff'
              pointBorderWidth: 1
              pointHoverRadius: 5
              pointHoverBackgroundColor: '#0084ff'
              pointHoverBorderColor: '#0084ff'
              pointHoverBorderWidth: 2
              pointRadius: 1
              pointHitRadius: 10
              data: [65 59 80 81 56 55 40]
              spanGaps: false
          ]
      }


module.exports = MessageFrequency
