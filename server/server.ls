pg = require 'pg'
path = require 'path'
connectionString = process.env.DATABASE_URL or 'postgres://localhost:5432/minerva'

getMessages = (req, res, next) ->
  results = []
  pg.connect connectionString, (err, client, done) ->
    if err
      done!
      console.log err
      return (res.status 500).json {success: false}
    query = client.query 'SELECT text, sender_id, timestamp FROM messages WHERE conversation_id = $1', [req.query.conversation_id]
    query.on 'row', (row) ->
      results.push row
      return 
    query.on 'end', ->
      done!
      res.json results
    return 
  return 

postMessage = (req, res, next) ->
  data = {
    (req.body)conversation_id
    (req.body)sender_id
    (req.body)text
    (req.body)timestamp
  }
  pg.connect connectionString, (err, client, done) ->
    if err
      done!
      console.log err
      return (res.status 500).json {success: false}
    query = client.query 'INSERT INTO messages(conversation_id, sender_id, text, timestamp) values($1, $2, $3, $4)', [
      data.conversation_id
      data.sender_id
      data.text
      data.timestamp
    ]
    query.on 'end', ->
      done!
      (res.status 200).json {success: true}
    return 
  return 

module.exports = {
  getMessages
  postMessage
}