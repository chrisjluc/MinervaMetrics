messageDAO = require '../daos/message_dao'
indico = require './indico'

module.exports =
  getEmotionsMetric: (query, callback) ->
    messageDAO.getMessages query, (err, messages) ->
      if err
        console.error err
        return callback err, null

      text = messages.filter (message) ->
        message.text != null
      .map (message) ->
        message.text
      .join ' '

      indico.getEmotions text,
        (emotions) ->
          emotions = [{emotion: emotion, score: score} for emotion, score of emotions]
          emotions.sort (a, b) ->
            b.score - a.score
          callback null, emotions
        (err) ->
          console.error err
          callback err, null
