require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
FacebookLogin = react.createFactory (require 'react-facebook-login-component').FacebookLogin
{button, div, p} = react.DOM
MostFrequentWords = react.createFactory require '../metrics/most_frequent_words'
MessageFrequency = react.createFactory require '../metrics/message_frequency'
FrequentTopics = react.createFactory require '../metrics/frequent_topics'
MostTalkative = react.createFactory require '../metrics/most_talkative'
Emotions = react.createFactory require '../metrics/emotions'

class HomePage extends react.Component

  responseFacebook: (resp) ->
    if !resp.error
      console.log JSON.stringify resp
      browserHistory.push "/conversations/#{resp.id}"

  render: ~>
    div className: 'c-home-page',
      div className: 'info'
        p {}, ''
      div className: 'backdrop',
        MostFrequentWords data: testData.topWordsData
        Emotions data: testData.emotionsData
        MostTalkative {}
        MessageFrequency data: testData.messageCountData
        FrequentTopics style: {height: '400px'}, data: testData.topicsData

      FacebookLogin {
        socialId: '361098944231495'
        language: 'en_US'
        scope: 'public_profile,email'
        fields: 'email,name'
        responseHandler: @responseFacebook
        xfbml: true
        version: 'v2.3'
        class: 'facebook-login'
        buttonText: 'Login With Facebook to analyze your own messages!'
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
      * timestamp: 1472702400000 - 0*2592000000
        count: 50
      * timestamp: 1472702400000 - 1*2592000000
        count: 60
      * timestamp: 1472702400000 - 2*2592000000
        count: 77
      * timestamp: 1472702400000 - 3*2592000000
        count: 40
      * timestamp: 1472702400000 - 4*2592000000
        count: 30
      * timestamp: 1472702400000 - 5*2592000000
        count: 100
      * timestamp: 1472702400000 - 6*2592000000
        count: 110
      * timestamp: 1472702400000 - 7*2592000000
        count: 130
      * timestamp: 1472702400000 - 8*2592000000
        count: 300
      * timestamp: 1472702400000 - 9*2592000000
        count: 20
      * timestamp: 1472702400000 - 10*2592000000
        count: 40
      * timestamp: 1472702400000 - 11*2592000000
        count: 55
    emotionsData:
      * emotion: 'Happy'
        score: 100
      * emotion: 'Sad'
        score: 10
      * emotion: 'Angry'
        score: 20
      * emotion: 'Silly'
        score: 75
      * emotion: 'Nervous'
        score: 40
    topicsData:
      * topic: 'Sports'
        score: 50
      * topic: 'School'
        score: 80
      * topic: 'Gaming'
        score: 20
      * topic: 'Work'
        score: 75
      * topic: 'Music'
        score: 60



module.exports = HomePage
