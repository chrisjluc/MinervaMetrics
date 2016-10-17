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

module.exports =
  countWords: countWords
