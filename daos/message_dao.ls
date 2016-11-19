pool = require '../database/pool.ls'

getMessages = (query, callback) ->
  results = []
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err
      return callback err, null

    if !query.conversation_id
      done!
      console.error 'conversation_id is undefined'
      return callback true, null

    args = [query.conversation_id]
    startTimestamp = query.start_timestamp
    endTimestamp = query.end_timestamp

    sql_query = 'SELECT text, sender_id, timestamp FROM message WHERE conversation_id = $1'

    if startTimestamp
      sql_query += ' AND timestamp >= to_timestamp($2)'
      args.push startTimestamp

    if endTimestamp
      if startTimestamp
        sql_query += ' AND timestamp <= to_timestamp($3)'
      else
        sql_query += ' AND timestamp <= to_timestamp($2)'
      args.push endTimestamp

    client.query sql_query, args, (err, result) ->
        done!
        if err
          console.error err
        callback null result.rows

saveMessages = (data, callback) ->

  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err
      return callback err
    console.log JSON.stringify data
    client.query(
      'INSERT INTO message(message_id, conversation_id, sender_id, text, timestamp) values($1, $2, $3, $4, $5) ON CONFLICT DO NOTHING',
      data,
      (err, result) ->
        done!
        if err
          console.error err
        if callback
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
  saveMessages: saveMessages
  getMostRecentMessage: getMostRecentMessage
