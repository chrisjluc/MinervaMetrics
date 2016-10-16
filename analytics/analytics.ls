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


module.exports =
  countWords: countWords
