require './index.styl'
react = require 'react'
browserHistory = require 'react-router/lib/browserHistory'
FacebookLogin = react.createFactory (require 'react-facebook-login-component').FacebookLogin
{button, div, p} = react.DOM


class HomePage extends react.Component
  
  responseFacebook: (resp) ->
    console.log JSON.stringify resp
    if !resp.error
      browserHistory.push "/conversations/#{resp.email}"

  render: ~>
    div className: 'c-home-page',
      div className: 'description',
        p {},
          '''
          Analyze your Facebook messages
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
