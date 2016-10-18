pool = require '../database/pool'

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
      where_query += ' AND timestamp >= to_timestamp($2)'
      args.push startTimestamp

    if endTimestamp
      if startTimestamp
        where_query += ' AND timestamp <= to_timestamp($3)'
      else
        where_query += ' AND timestamp <= to_timestamp($2)'
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



module.exports =
  getMessageCountMetric: getMessageCountMetric
