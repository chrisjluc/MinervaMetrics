pool = require '../database/pool'
sanitizer = require '../database/sanitizer'

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

getHasUpdates = (conversationId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT has_new_messages FROM conversation WHERE conversation_id = $1',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.error err
        callback null result.rows[0]['has_new_messages']
    )

createParticipants = (data, callback) ->
  #building the query
  q = "INSERT INTO facebook_user(user_id,name) VALUES"
  for d in data
    q += "(" + d[0] + ",'" + sanitizer.cleanText(d[1]) + "'),"
  q  += ' ON CONFLICT DO NOTHING'
  q = q.replace('), ', ') ')

  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err
      return callback err
    client.query(
      q,
      (err, result) ->
        done!
        if err
          console.error err

        callback null
    )

createConversation = (data, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err
      return callback err
    client.query(
      'INSERT INTO conversation(conversation_id) VALUES($1) ON CONFLICT DO NOTHING',
      [data],
      (err, result) ->
        done!
        if err
          console.error err
        callback null
    )

createUserConversations = (data, callback) ->
  #building the query
  q = 'INSERT INTO user_conversation(conversation_id,user_id) VALUES'
  for d in data
    q += "(" +d[0]+ ",'" +d[1]+ "'),"
  q  += ' ON CONFLICT DO NOTHING'
  q = q.replace('), ', ') ')

  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err
      if callback
        callback err
      return
    client.query(
      q,
      (err, result) ->
        done!
        if err
          console.error err
        if callback
          callback null
    )

module.exports =
  getConversations: getConversations
  getParticipants: getParticipants
  getHasUpdates: getHasUpdates
  createParticipants: createParticipants
  createConversation: createConversation
  createUserConversations: createUserConversations
