config = require 'config'
indico = require 'indico.io'

indico.apiKey = config.get 'indico_api_key'

module.exports =

  getTopics: (text, success, error) ->
    indico.textTags text
      .then success
      .catch error

  getEmotions: (text, success, error) ->
    indico.emotion text
      .then success
      .catch error

  getPoliticLeanings: (text, success, error) ->
    indico.political text
      .then success
      .catch error
