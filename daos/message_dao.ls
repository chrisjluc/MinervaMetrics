pool = require '../database/pool.ls'

getMessages = (conversationId, callback) ->
  results = []
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
      return callback err null
    client.query(
      'SELECT text, sender_id, timestamp FROM messages WHERE conversation_id = $1',
      [conversationId],
      (err, result) ->
        done!
        if err
          console.err err
        callback null result.rows
    )

postMessages = (req, res, next) ->
  data = {
    (req.body)conversation_id
    (req.body)sender_id
    (req.body)text
    (req.body)timestamp
  }
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.err err
      return res.status 500 .json success: false
    query = client.query 'INSERT INTO messages(conversation_id, sender_id, text, timestamp) values($1, $2, $3, $4)', [
      data.conversation_id
      data.sender_id
      data.text
      data.timestamp
    ], (err, result) ->
      done!
      if err
        console.err err
        return res.status 500 .json success: false
      res.status 200 .json success: true

module.exports =
  getMessages: getMessages
  postMessages: postMessages
