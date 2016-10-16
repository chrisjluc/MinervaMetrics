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

countMessages = (conversationId) ->
  messages = messageDAO.getMessages conversationId
  messageCounts = {}

  for message in messages
    senderId = message.sender_id
    if !messageCounts.hasOwnProperty senderId
      messageCounts[senderId] =
        by_day: {}
        by_hour: {}
    timestamp_by_hour = hour * parseInt message.timestamp / hour
    timestamp_by_day = day * parseInt message.timestamp / day
    if !messageCounts[senderId]['by_day'].hasOwnProperty timestamp_by_day
      messageCounts[senderId]['by_day'][timestamp_by_day] = 0
    if !messageCounts[senderId]['by_hour'].hasOwnProperty timestamp_by_hour
      messageCounts[senderId]['by_hour'][timestamp_by_hour] = 0

    messageCounts[senderId]['by_day'][timestamp_by_day]++
    messageCounts[senderId]['by_hour'][timestamp_by_hour]++

  Object.keys messageCounts .forEach (senderId) ->
    Object.keys messageCounts[senderId]['by_day'] .forEach (day) ->
      console.log messageCounts[senderId]['by_day'][day]
    Object.keys messageCounts[senderId]['by_hour'] .forEach (hour) ->
      console.log messageCounts[senderId]['by_hour'][hour]

module.exports =
  topWords: topWords
