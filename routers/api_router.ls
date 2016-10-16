require! express
metricsDAO = require '../daos/metrics_dao'

apiRouter = express.Router!

apiRouter.get '/analytics/top-words', (req, res) ->
  conversationId = req.query.conversationId
  senderId = req.query.senderId
  messages = metricsDAO.getTopWordsMetric(conversationId, senderId)
  res.status 200
    ..json messages

module.exports = apiRouter
