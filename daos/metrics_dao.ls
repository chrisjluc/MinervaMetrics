pool = require '../database/pool.ls'

saveWordCountMetric = (conversationId, senderId, word, count) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err
    client.query(
      'INSERT INTO wordcount VALUES ($1, $2, $3, $4)',
      [conversationId, senderId, word, count],
      (err, result) ->
        done!
        if err
          console.log err
        console.log 'succesfully saved word count metric'
    )

getTopWordsMetric = (conversationId, senderId, callback) ->
  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.log err

    query = 'SELECT sender_id, word, count FROM wordcount WHERE conversation_id=$1'
    values = [conversationId]
    if senderId
      query = query.concat ' AND sender_id=$2'
      values.push senderId
    query = query.concat ' ORDER BY count DESC LIMIT 100'

    client.query(
      query,
      values,
      (err, result) ->
        done!
        callback err, result.rows
    )

module.exports =
  saveWordCountMetric: saveWordCountMetric
  getTopWordsMetric: getTopWordsMetric
