messageDAO = require '../daos/message_dao'
textSanitizer = require './text_sanitizer'
indico = require './indico'

module.exports =
  getTopicsMetric: (query, callback) ->
    messageDAO.getMessages query, (err, messages) ->
      if err
        console.error err
        return callback err, null

      text = messages.map (obj) ->
        obj.text
      .join ' '

      indico.getTopics text,
        (topics) ->
          topics = [{topic: topic.replace(/_/g, ' '), score: score} for topic, score of topics]
          topics.sort (a, b) ->
            b.score - a.score
          callback null, topics
        (err) ->
          console.error err
          callback err, null
