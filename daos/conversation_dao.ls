pool = require '../database/pool.ls'

getConversations = (userId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT conversation_id FROM user_conversation WHERE user_id = $1',
      [userId],
      (err, result) ->
        done!
        if err
          console.err err
        callback null result.rows
    )

getParticipants = (conversationId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT user_id FROM user_conversation WHERE conversation_id = $1',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.err err
        callback null result.rows
    )

postParticipants = (data, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.err err
      return callback err
    client.query(
      'INSERT INTO user_conversation(conversation_id,user_id) values($1,$2)',
      data,
      (err, result) ->
        done!
        if err
          console.err err
        callback null
    )

module.exports =
  getConversations: getConversations
  getParticipants: getParticipants
