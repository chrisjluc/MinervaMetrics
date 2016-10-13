path = require 'path'


module.exports =

  entry: path.join __dirname, 'client/index.ls'

  output:
    path: path.join __dirname, 'public'
    publicPath: '/'
    filename: 'bundle.js'
    pathinfo: yes

  resolve:
    extensions:
      * ''
      * '.ls'
      * '.js'

  module:
    loaders:
      * test: /\.ls$/ loader: \livescript
      * test: /\.styl$/ loader: \style!css!stylus
      * test: /\.css$/ loader: \style!css
      * test: /\.png$/ loader: \file
