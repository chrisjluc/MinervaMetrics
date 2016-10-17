pool = require '../database/pool.ls'

getConversations = (userId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err
      return callback err null
    client.query(
      'SELECT conversation_id FROM user_conversation WHERE user_id = $1',
      [userId],
      (err, result) ->
        done!
        if err
          console.error err
        callback null result.rows
    )

getParticipants = (conversationId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT facebook_user.name, facebook_user.user_id FROM user_conversation, facebook_user WHERE user_conversation.conversation_id = $1 AND user_conversation.user_id = facebook_user.user_id',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.error err
        callback null result.rows
    )

getLatestTime = (conversationId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT max(timestamp) as latest_time FROM message WHERE message.conversation_id = $1',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.error err
        callback null result.rows
    )

getCount = (conversationId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT COUNT(message_id) FROM message WHERE message.conversation_id = $1',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.error err
        callback null result.rows
    )

postParticipants = (data, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.err err
      return callback err
    client.query(
      'INSERT INTO user_conversation(conversation_id,user_id) VALUES($1,$2)',
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
  getLatestTime: getLatestTime
  getCount: getCount
