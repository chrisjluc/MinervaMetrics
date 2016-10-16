pg = require 'pg'
connectionString = process.env.DATABASE_URL or 'postgres://localhost:5432/minerva'

getMessages = (conversationId, callback) ->
  results = []
  pg.connect connectionString, (err, client, done) ->
    if err
      done!
      console.log err
      callback err null
    query = client.query 'SELECT text, sender_id, timestamp FROM messages WHERE conversation_id = $1', [conversationId]
    query.on 'row', (row) ->
      results.push row
      return
    query.on 'end', ->
      done!
      callback null results
    return
  return

module.exports =
  getMessages: getMessages
