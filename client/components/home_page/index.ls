require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
FacebookLogin = react.createFactory (require 'react-facebook-login-component').FacebookLogin
{button, div, p} = react.DOM


class HomePage extends react.Component
  
  responseFacebook: (resp) ->
    if !resp.error
      browserHistory.push "/conversations/#{resp.id}"

  render: ~>
    div className: 'c-home-page',
      div className: 'description',
        p {},
          '''
          Minerva Metrics is a Conversation Analysis tool that generates fun and interesting metrics from your Facebook messages.
          Login with Facebook to get started!
          '''
      FacebookLogin {
        socialId:'361098944231495'
        language: 'en_US'
        scope: 'public_profile,email'
        fields: 'email,name'
        responseHandler: @responseFacebook
        xfbml: true
        version: 'v2.5'
        class: 'facebook-login'
        buttonText: 'Login With Facebook'
      }


module.exports = HomePage
