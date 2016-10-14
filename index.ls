express = require 'express'
webpack = require 'webpack'
webpackDevMiddleware = require 'webpack-dev-middleware'

apiRoutes = require './routers/api_router'
mainRoutes = require './routers/main_router'

app = express!
  ..set 'view engine', 'pug'
  ..set 'views', __dirname
  ..use '/', mainRoutes
  ..use '/api', apiRoutes
  ..use webpackDevMiddleware webpack require './webpack-config.ls'
  ..listen 8000
