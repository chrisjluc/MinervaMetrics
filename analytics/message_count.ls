messageCountDAO = require '../daos/message_count_dao'

getMessageCountOverTimeMetric = (query, callback) ->
  query.period = (query.period || 'hour')
  messageCountDAO.getMessageCountOverTime query, (err, rows) ->
    if err
      return callback err, null
    result = postProcessMessageCountResults rows, query.period
    callback null, result


postProcessMessageCountResults = (results, period) ->
  if !results || results.length == 0
    return []

  rows = results.map (obj) ->
    date = convertDateObjToJSDate obj
    timestamp = date.getTime!
    [timestamp, parseInt obj.count]

  timestamps = rows.map (x) -> x[0]
  timestampToCountMap = new Map rows

  firstTimestamp = timestamps.reduce (a, b) ->
    Math.min a, b

  lastTimestamp = timestamps.reduce (a, b) ->
    Math.max a, b

  ret = []
  date = new Date firstTimestamp
  while date <= lastTimestamp
    timestamp = date.getTime!
    count = (timestampToCountMap.get timestamp) || 0
    ret.push timestamp: timestamp, count: count
    incrementPeriod date, period

  return ret

incrementPeriod = (date, period) ->
    switch period
    when 'hour' then date.setHours date.getHours! + 1
    when 'day' then date.setDate date.getDate! + 1
    when 'month' then date.setMonth date.getMonth! + 1
    date

convertDateObjToJSDate = (obj) ->
    year = obj.year
    month = obj.month
    day = obj.day || 1
    hour = obj.hour || 0
    new Date year, month, day, hour


module.exports =
  getMessageCountOverTimeMetric: getMessageCountOverTimeMetric
  incrementPeriod: incrementPeriod
  convertDateObjToJSDate: convertDateObjToJSDate
  postProcessMessageCountResults: postProcessMessageCountResults
