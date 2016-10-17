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
          labels: <[ Sports School Gaming Work ]>
          datasets: [
            {
              label: 'Topics of Discussion'
              backgroundColor: '#0084ff'
              borderColor: '#0084ff'
              pointBackgroundColor: '#0084ff'
              pointBorderColor: '#fff'
              pointHoverBackgroundColor: '#fff'
              pointHoverBorderColor: '#0084ff'
              data: [65 59 90 81]
            }
          ]
      }


module.exports = FrequentTopics
