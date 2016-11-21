messageDAO = require '../daos/message_dao'
textSanitizer = require './text_sanitizer'

getTopWordsMetric = (query, callback) ->
  messageDAO.getMessages query, (err, messages) ->
    /*
    # Segregate by senders
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
    */
    if err
      return callback err, null

    wordCounts = new Map!
    for message in messages
      if message.text == null
        continue
      text = message.text .toLowerCase!
      words = textSanitizer.removePunctuation text .split ' '
      words = textSanitizer.removeSingleLetterWords textSanitizer.removeStopWords words
      for word in words
        wordCount = wordCounts.get word
        wordCounts.set word, (wordCount || 0) + 1

    ret = []
    wordCounts.forEach (count, word) ->
      ret.push word: word, count: count
    ret.sort (a, b) ->
      b.count - a.count
    callback null, ret

module.exports =
  getTopWordsMetric: getTopWordsMetric
