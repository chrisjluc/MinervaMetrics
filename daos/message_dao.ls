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
          console.error err
        callback null result.rows
    )

postMessages = (data, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err
      return callback err
    client.query(
      'INSERT INTO message(message_id, conversation_id, sender_id, text, timestamp) values($1, $2, $3, $4, $5)',
      data,
      (err, result) ->
        done!
        if err
          console.error err
        callback null
    )
getMostRecentMessage = (conversationId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT * FROM message WHERE message.conversation_id = $1 ORDER BY timestamp DESC LIMIT 1',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.error err
        callback null result.rows[0]
    )

module.exports =
  getMessages: getMessages
  postMessages: postMessages
  getMostRecentMessage: getMostRecentMessage
