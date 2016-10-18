require! express
topWordsAnalytics = require '../analytics/top_words_analytics'
conversationDAO = require '../daos/conversation_dao'
messageDAO = require '../daos/message_dao'
messageCountDAO = require '../daos/message_count_dao'
metricsDAO = require '../daos/metrics_dao'
messageCountAnalytics = require '../analytics/message_count.ls'

apiRouter = express.Router!

apiRouter.get '/analytics/top-words', (req, res) ->
  topWordsAnalytics.getTopWordsMetric req.query, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.get '/analytics/message-count', (req, res) ->
  messageCountAnalytics.getMessageCountOverTimeMetric req.query, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.post '/messages/', messageDAO.postMessages

apiRouter.get '/messages/', (req, res) ->
  messageDAO.getMessages req.query.conversation_id, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.get '/conversations/', (req, res) ->
  conversationDAO.getConversations req.query.user_id, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.get '/participants/', (req, res) ->
  conversationDAO.getParticipants req.query.conversation_id, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.get '/conversation-data/', (req, res) ->
  hash = {}
  conversationDAO.getParticipants req.query.conversation_id, (err, participants) ->
    if err
      return res.status 500 .json success: false
    hash['participants'] = participants
    messageDAO.getMostRecentMessage req.query.conversation_id, (err, message) ->
      if err
        return res.status 500 .json success: false
      hash['latest_time'] = message.timestamp.getTime()
      messageCountDAO.getTotalMessageCount req.query.conversation_id, (err, count) ->
        if err
          return res.status 500 .json success: false
        hash['count'] = count[0]['count']
        res.status 200
          ..json hash

module.exports = apiRouter
