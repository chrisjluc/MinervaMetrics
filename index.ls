express = require 'express'
webpack = require 'webpack'
bodyParser = require 'body-parser'
webpackDevMiddleware = require 'webpack-dev-middleware'
cors = require 'cors'

apiRoutes = require './routers/api_router'
mainRoutes = require './routers/main_router'

app = express!
  ..set 'view engine', 'pug'
  ..set 'views', __dirname
  ..use bodyParser.json!
  ..use bodyParser.urlencoded extended: true
  ..use webpackDevMiddleware webpack require './webpack-config.ls'
  ..use cors!
  ..use '/api', apiRoutes
  ..use '/', mainRoutes
  ..listen 8000
