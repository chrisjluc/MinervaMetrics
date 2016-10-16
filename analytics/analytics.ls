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


module.exports =
  topWords: topWords
