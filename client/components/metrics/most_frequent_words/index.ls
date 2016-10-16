require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
BarChart = react.createFactory (require 'react-chartjs' .Bar)
{div, table, tbody, td, tr} = react.DOM


class MostFrequentWords extends react.Component

  render: ~>
    div className: 'c-most-freq-words',
      div className: 'metric-title', 'Most Frequent Words'
      BarChart {
        className: 'bar-chart'
        data:
          labels: @props.mostFrequentWords.map (wordInfo) -> wordInfo.word
          datasets: [
              label: 'Word Count'
              data: @props.mostFrequentWords.map (wordInfo) -> wordInfo.count
              backgroundColor:
                * 'rgba(255, 99, 132, 0.2)'
                * 'rgba(54, 162, 235, 0.2)'
              borderColor:
                * 'rgba(255,99,132,1)'
                * 'rgba(54, 162, 235, 1)'
              borderWidth: 1
          ]
      }


module.exports = MostFrequentWords
      # table className: 'words-table',
      #   console.log JSON.stringify @props.mostFrequentWords
      #   @props.mostFrequentWords.map (wordInfo, i) ->
      #     tbody key: i,
      #       tr {},
      #         td {}, wordInfo.word
      #         td {}, wordInfo.count




