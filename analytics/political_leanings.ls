messageDAO = require '../daos/message_dao'
indico = require './indico'

module.exports =
  getPoliticalLeaningsMetric: (query, callback) ->
    messageDAO.getMessages query, (err, messages) ->
      if err
        console.error err
        return callback err, null

      text = messages.filter (message) ->
        message.text != null
      .map (message) ->
        message.text
      .join ' '

      indico.getPoliticLeanings text,
        (politicalLeanings) ->
          politicalLeanings = [{political_leaning: p, score: score} for p, score of politicalLeanings]
          politicalLeanings.sort (a, b) ->
            b.score - a.score
          callback null, politicalLeanings
        (err) ->
          console.error err
          callback err, null
