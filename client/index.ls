require './base_css'
react = require 'react'
reactDom = require 'react-dom'
Root = require './components/root'


reactDom.render(
  react.createElement Root
  document.querySelector 'main'
)
