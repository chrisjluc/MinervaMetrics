messageDAO = require '../daos/message_dao'
metricsDAO = require '../daos/metrics_dao'

textSanitizer = require './text_sanitizer'

countWords = (conversationId) ->
  messages = messageDAO.getMessages conversationId
  senders = {}

  for message in messages
    senderId = message.sender_id
    if !senders.hasOwnProperty senderId
      senders[senderId] = {}
    words = textSanitizer.removePunctuation message.text .toLowerCase!.split ' '
    for word in words
      if !senders[senderId].hasOwnProperty word
        senders[senderId][word] = 0
      senders[senderId][word]++

  Object.keys senders .forEach (senderId) ->
    Object.keys senders[senderId] .forEach (word) ->
      count = senders[senderId][word]
      metricsDAO.saveWordCountMetric conversationId, senderId, word, count


hour = 1000 * 60 * 60
day = hour * 24
day_key = 'by_day'
hour_key = 'by_hour'

countMessages = (conversationId) ->
  messageDAO.getMessages conversationId, (err, messages) ->
    messageCounts = new Map!

    for message in messages
      senderId = message.sender_id
      if !messageCounts.get senderId
        messageCounts.set senderId, new Map [[day_key, new Map!] [hour_key, new Map!]]
      timestamp_by_hour = hour * parseInt message.timestamp / hour
      timestamp_by_day = day * parseInt message.timestamp / day
      senderCounts = messageCounts.get senderId

      day_count = senderCounts.get day_key .get timestamp_by_day
      senderCounts.get day_key .set timestamp_by_day, (day_count || 0) + 1
      hour_count = senderCounts.get hour_key .get timestamp_by_hour
      senderCounts.get hour_key .set timestamp_by_hour, (hour_count || 0) + 1

    messageCounts.forEach (map, senderId) ->
      map.get day_key .forEach (count, day) ->
        console.log count
      map.get hour_key .forEach (count, day) ->
        console.log count

module.exports =
  countWords: countWords
