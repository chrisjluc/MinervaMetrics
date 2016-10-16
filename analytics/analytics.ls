messageDAO = require '../daos/message_dao'
metricsDAO = require '../daos/metrics_dao'

textSanitizer = require './text_sanitizer'

NUM_TOP_WORDS = 1000

topWords = (conversationId) ->
  messages = messageDAO.getMessages conversationId
  senders = {}

  # Count top words
  for message in messages
    senderId = message.sender_id
    if !senders.hasOwnProperty senderId
      senders[senderId] = {}
    words = textSanitizer.removePunctuation message.text .toLowerCase!.split ' '
    for word in words
      if !senders[senderId].hasOwnProperty word
        senders[senderId][word] = 0
      senders[senderId][word]++

  # Get top words by descending count
  Object.keys senders .forEach (senderId) ->
    word_tuples = []
    # Create tuple of word and it's count
    Object.keys senders[senderId] .forEach (word) ->
      word_tuples.push([word, senders[senderId][word]])

    word_tuples.sort (a, b) ->
      b[1] - a[1]

    topWordCount = 0
    for tuple in word_tuples
      word = tuple[0]
      count = tuple[1]
      metricsDAO.saveTopWordsMetric conversationId, senderId, word, count
      if ++topWordCount >= NUM_TOP_WORDS
        break


hour = 1000 * 60 * 60
day = hour * 24
day_key = 'by_day'
hour_key = 'by_hour'

countMessages = (conversationId) ->
  messages = messageDAO.getMessages conversationId
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
  topWords: topWords
