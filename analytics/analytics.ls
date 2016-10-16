messageDAO = require '../daos/message_dao'
metricsDAO = require '../daos/metrics_dao'

textSanitizer = require './text_sanitizer'

countWords = (conversationId) ->
  messageDAO.getMessages conversationId, (err, messages) ->
    wordCounts = new Map!
    for message in messages
      senderId = message.sender_id
      if !wordCounts.get senderId
        wordCounts.set senderId, new Map!
      text = message.text .toLowerCase!
      words = textSanitizer.removeStopWords textSanitizer.removePunctuation text .split ' '
      for word in words
        wordCount = wordCounts.get senderId .get word
        wordCounts.get senderId .set word, (wordCount || 0) + 1

    wordCounts.forEach (words, senderId) ->
      words.forEach (count, word) ->
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
