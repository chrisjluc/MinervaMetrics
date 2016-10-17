react = require 'react'
Route = react.createFactory require 'react-router/lib/Route'
Router = react.createFactory require 'react-router/lib/Router'
Redirect = react.createFactory require 'react-router/lib/Redirect'
browserHistory = require 'react-router/lib/browserHistory'
Layout = require '../layout'
HomePage = require '../home_page'
Conversations = require '../conversations'


class Root extends react.Component

  render: ->
    Router history: browserHistory,
      Redirect from: '/', to: '/welcome'
      Route path: '/', component: Layout,
        Route path: '/welcome', component: HomePage
        Route path: '/conversations/:userId', component: Conversations


module.exports = Root
