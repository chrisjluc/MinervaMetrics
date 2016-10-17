require! express
conversationDAO = require '../daos/conversation_dao'
messageDAO = require '../daos/message_dao'
metricsDAO = require '../daos/metrics_dao'

apiRouter = express.Router!

apiRouter.get '/analytics/top-words', (req, res) ->
  conversationId = req.query.conversation_id
  senderId = req.query.sender_id
  metricsDAO.getTopWordsMetric conversationId, senderId, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.get '/analytics/message-count', (req, res) ->
  metricsDAO.getMessageCountMetric req.query, (err, result) ->
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
    conversationDAO.getLatestTime req.query.conversation_id, (err, time) ->
      if err
        return res.status 500 .json success: false
      hash['latest_time'] = time[0]['latest_time']
      conversationDAO.getCount req.query.conversation_id, (err, count) ->
        if err
          return res.status 500 .json success: false
        hash['count'] = count[0]['count']
        res.status 200
          ..json hash

module.exports = apiRouter
