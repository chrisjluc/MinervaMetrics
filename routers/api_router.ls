require! express
async = require 'async'
conversationParser = require '../parse/conversation_parser'
messageParser = require '../parse/message_parser'
topWordsAnalytics = require '../analytics/top_words'
conversationDAO = require '../daos/conversation_dao'
messageDAO = require '../daos/message_dao'
messageCountDAO = require '../daos/message_count_dao'
messageCountAnalytics = require '../analytics/message_count'
topicsAnalytics = require '../analytics/topics'
emotionsAnalytics = require '../analytics/emotions'
politicalLeaningsAnalytics = require '../analytics/political_leanings'

apiRouter = express.Router!

apiRouter.post '/parse/', (req, res) ->
  conversationParser.parseConversation req.body.token

apiRouter.post '/parseMessages/', (req, res) ->
  messageParser.parseMessages req.body.token, req.body.conversationId

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

apiRouter.get '/analytics/emotions', (req, res) ->
  emotionsAnalytics.getEmotionsMetric req.query, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

apiRouter.get '/analytics/political-leanings', (req, res) ->
  politicalLeaningsAnalytics.getPoliticalLeaningsMetric req.query, (err, result) ->
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
  conversationList = []
  conversationDAO.getConversations req.query.user_id, (err, conversations) ->
    if err
      return res.status 500 .json success: false
    async.each (conversations.map ((conversation) ->
      conversation.'conversation_id'
      )), ((id, callback) ->
      hash = {'conversation_id': id}
      conversationDAO.getMetaData id, (err, metaData) ->
        if err
          callback 500
        hash['has_updates'] = metaData['has_new_messages']
        hash['latest_time'] = metaData['last_updated_time']
        conversationDAO.getParticipants id, (err, participants) ->
          if err
            callback 500
          hash['participants'] = participants
          messageCountDAO.getTotalMessageCount id, (err, count) ->
            if err
              callback 500
            hash['count'] = count[0]['count']
            conversationList.push(hash)
            callback null
    ), (err) ->
      if err
        return res.status err .json success: false
      res.status 200
        ..json conversationList.sort((a, b) -> b.latest_time - a.latest_time)

apiRouter.get '/participants/', (req, res) ->
  conversationDAO.getParticipants req.query.conversation_id, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

module.exports = apiRouter
