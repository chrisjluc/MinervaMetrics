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


getMessageCountMetric  = (query, callback) ->

  pool.acquireClient (err, client, done) ->
    if err
      done!
      console.error err

    conversationId = query.conversation_id
    period = query.period
    startTimestamp = query.start_timestamp
    endTimestamp = query.end_timestamp

    if !period
      period = 'hour'

    args = [conversationId]
    select_query = '
        SELECT \
          COUNT(*), \
          EXTRACT(year from timestamp) AS year, \
          EXTRACT(month from timestamp) AS month \
        '
    where_query = ' WHERE conversation_id = $1'
    from_query = ' FROM message'
    group_query = ' GROUP BY year, month'

    if period == 'hour' || period == 'day'
      select_query += ', EXTRACT(day from timestamp) AS day'
      group_query += ', day'

    if period == 'hour'
      select_query += ', EXTRACT(hour from timestamp) AS hour'
      group_query += ', hour'

    if startTimestamp
      where_query += ' AND timestamp >= $2'
      args.push startTimestamp
    if endTimestamp
      where_query += ' AND timestamp <= $3'
      args.push endTimestamp

    final_query = select_query + from_query + where_query + group_query
    console.log 'query string: ' + final_query
    console.log 'query args: ' + args
    client.query final_query, args, (err, result) ->
      done!
      if err || !result
        if err
          console.error err
        return callback err, []
      callback err, postProcessMessageCountResults result, period

PERIOD_TO_MS =
  'hour': 1000 * 60 * 60
  'day': 1000 * 60 * 60 * 24

postProcessMessageCountResults = (result, period) ->
  rows = result.rows
  rows = rows.map (obj) ->
    year = obj.year
    month = obj.month
    day = obj.day || 0
    hour = obj.hour || 0
    date = new Date year, month, day, hour
    timestamp = date.getTime!
    return [timestamp, parseInt obj.count]

  timestamps = rows.map (x) -> x[0]
  timestampMap = new Map rows

  firstTimestamp = timestamps.reduce (a, b) ->
    Math.min a, b

  lastTimestamp = timestamps.reduce (a, b) ->
    Math.max a, b

  ret = []
  date = new Date firstTimestamp
  while date <= lastTimestamp
    console.log date
    count = 0
    if timestampMap.get date.getTime!
      count = timestampMap.get date.getTime!
    ret.push timestamp:date.getTime!, count: count
    switch period
    when 'hour' then date.setHours date.getHours! + 1
    when 'day' then date.setDate date.getDate! + 1
    when 'month' then date.setMonth date.getMonth! + 1

  return ret

module.exports =
  saveWordCountMetric: saveWordCountMetric
  getTopWordsMetric: getTopWordsMetric
  getMessageCountMetric: getMessageCountMetric
