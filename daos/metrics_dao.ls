saveWordCountMetric = (conversationId, senderId, word, count) ->
  console.log 'save metric to db'

getTopWordsMetric = (conversationId) ->
  console.log 'get top words metrics from db'

module.exports =
  saveWordCountMetric: saveWordCountMetric
  getTopWordsMetric: getTopWordsMetric
