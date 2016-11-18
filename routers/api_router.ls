require! express
conversationParser = require '../parse/conversation_parser'
topWordsAnalytics = require '../analytics/top_words'
conversationDAO = require '../daos/conversation_dao'
messageDAO = require '../daos/message_dao'
messageCountDAO = require '../daos/message_count_dao'
messageCountAnalytics = require '../analytics/message_count'
topicsAnalytics = require '../analytics/topics'

apiRouter = express.Router!

apiRouter.post '/parse/', (req, res) ->
  conversationParser.parseConversation req.body.token

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

apiRouter.get '/analytics/topics', (req, res) ->
  topicsAnalytics.getTopicsMetric req.query, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.post '/messages/', messageDAO.saveMessages

apiRouter.get '/messages/', (req, res) ->
  messageDAO.getMessages req.query, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.get '/conversations/', (req, res) ->
  console.log 'here'
  conversationDAO.getConversations req.query.user_id, (err, result) ->
    console.log "result: #{JSON.stringify(result)}"
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
