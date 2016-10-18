require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
FacebookLogin = react.createFactory (require 'react-facebook-login-component').FacebookLogin
{button, div, p} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
MessageFrequency = react.createFactory require '../metrics/message_frequency'
FrequentTopics = react.createFactory require '../metrics/frequent_topics'

class HomePage extends react.Component
  
  responseFacebook: (resp) ->
    if !resp.error
      browserHistory.push "/conversations/#{resp.id}"

  render: ~>
    console.log testData.options
    div className: 'c-home-page',
      div className: 'info'
        p {}, ''
      # div className: 'description',
      #   p {},
      #     '''
      #     '''
      div className: 'backdrop',
        MostFrequentWords data: testData.topWordsData
        MessageFrequency data: testData.messageCountData
        FrequentTopics style: {height: '400px'}
      FacebookLogin {
        socialId: '361098944231495'
        language: 'en_US'
        scope: 'public_profile,email'
        fields: 'email,name'
        responseHandler: @responseFacebook
        xfbml: true
        version: 'v2.5'
        class: 'facebook-login'
        buttonText: 'Login With Facebook'
      }

  testData =
    topWordsData:
      * word: 'Legen'
        count: 300
      * word: 'wait'
        count: 150
      * word: 'for'
        count: 200
      * word: 'it'
        count: 75
      * word: 'dary'
        count: 350
    messageCountData:
      * timestamp: 'Jan'
        count: 50
      * timestamp: 'Feb'
        count: 60
      * timestamp: 'Mar'
        count: 77
      * timestamp: 'Apr'
        count: 40
      * timestamp: 'May'
        count: 30
      * timestamp: 'Jun'
        count: 100
      * timestamp: 'Jul'
        count: 110
      * timestamp: 'Aug'
        count: 130
      * timestamp: 'Sep'
        count: 300
      * timestamp: 'Oct'
        count: 20
      * timestamp: 'Nov'
        count: 40
      * timestamp: 'Dec'
        count: 55


module.exports = HomePage
