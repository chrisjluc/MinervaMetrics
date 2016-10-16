require! express
messageDAO = require '../daos/message_dao'
metricsDAO = require '../daos/metrics_dao'

apiRouter = express.Router!

apiRouter.get '/analytics/top-words', (req, res) ->
  conversationId = req.query.conversationId
  senderId = req.query.senderId
  messages = metricsDAO.getTopWordsMetric(conversationId, senderId)
  res.status 200
    ..json messages

apiRouter.post '/messages/', messageDAO.postMessages

apiRouter.get '/messages/', (req, res) ->
  messageDAO.getMessages req.query.conversation_id, (err, result) ->
    if err
      return (res.status 500).json success: false
    res.status 200
      ..json result

module.exports = apiRouter
