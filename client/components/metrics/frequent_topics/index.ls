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
          labels: @props.data.slice(0,10).map (topicsData) -> topicsData.topic
          datasets: [
            * label: 'Topic of Interest'
              backgroundColor: 'rgba(0,132,255, 0.4)'
              borderColor: 'rgba(0,132,255, 0.4)'
              pointBackgroundColor: 'rgba(0,132,255, 0.4)'
              pointBorderColor: 'rgba(0,132,255, 0.4)'
              pointHoverBackgroundColor: 'rgba(0,132,255, 0.8)'
              pointHoverBorderColor: 'rgba(0,132,255, 0.8)'
              data: @props.data.slice(0,10).map (topicsData) -> topicsData.score * 100
          ]
        options:
          scale:
            ticks:
              beginAtZero: true
      }


module.exports = FrequentTopics
