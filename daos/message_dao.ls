pool = require '../database/pool.ls'

getMessages = (conversationId, callback) ->
  results = []
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT text, sender_id, timestamp FROM message WHERE conversation_id = $1',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.err err
        callback null result.rows
    )

postMessages = (data, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.err err
      return callback err
    client.query(
      'INSERT INTO message(message_id, conversation_id, sender_id, text, timestamp) values($1, $2, $3, $4, $5)',
      data,
      (err, result) ->
        done!
        if err
          console.err err
        callback null
    )

module.exports =
  getMessages: getMessages
  postMessages: postMessages
