require './index.styl'
require '../index.styl'
react = require 'react'
{div} = react.DOM
LineChart = react.createFactory (require 'react-chartjs-2' .Line)

months = <[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]>

class MessageFrequency extends react.Component
  render: ~>
    div className: 'c-messages-freq',
      div className: 'metric-title', 'Message Frequency'
      LineChart {
        className: 'chart'
        data:
          labels: @props.data.slice(0,11).map (msg) -> months[new Date msg.timestamp .getMonth!]
          datasets: [
            * label: '# Messages'
              fill: false
              lineTension: 0.1
              backgroundColor: 'rgba(0,132,255, 0.4)'#0084ff'
              borderColor: 'rgba(0,132,255, 0.4)'
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
              data: @props.data.slice(0,11).map (msg) -> msg.count
              spanGaps: false
          ]
      }


module.exports = MessageFrequency
