require '../index.styl'
require './index.styl'
react = require 'react'
{div} = react.DOM
RadarChart = react.createFactory (require 'react-chartjs-2' .Radar)

class FrequentTopics extends react.Component
  render: ->
    div className: 'c-frequent-topics',
      div className: 'metric-title', 'Frequent Topics'
      RadarChart {
        className: 'chart'
        data:
          labels: <[ Sports School Gaming Work Music ]>
          datasets: [
            {
              label: 'Topics of Discussion'
              backgroundColor: 'rgba(0,132,255, 0.4)'
              borderColor: 'rgba(0,132,255, 0.4)'
              pointBackgroundColor: 'rgba(0,132,255, 0.4)'
              pointBorderColor: 'rgba(0,132,255, 0.4)'
              pointHoverBackgroundColor: 'rgba(0,132,255, 0.8)'
              pointHoverBorderColor: 'rgba(0,132,255, 0.8)'
              data: [90 50 90 60 60]
            }
          ]
        options:
          scale:
            ticks:
              beginAtZero: true
      }


module.exports = FrequentTopics
