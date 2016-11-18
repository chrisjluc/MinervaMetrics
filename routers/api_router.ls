require! express
async = require 'async'
conversationParser = require '../parse/conversation_parser'
messageParser = require '../parse/message_parser'
topWordsAnalytics = require '../analytics/top_words'
conversationDAO = require '../daos/conversation_dao'
messageDAO = require '../daos/message_dao'
messageCountDAO = require '../daos/message_count_dao'
messageCountAnalytics = require '../analytics/message_count'

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
      conversationDAO.getHasUpdates id, (err, hasUpdates) ->
        if err
          callback 500
        hash['has_updates'] = hasUpdates
        conversationDAO.getParticipants id, (err, participants) ->
          if err
            callback 500
          hash['participants'] = participants
          messageDAO.getMostRecentMessage id, (err, message) ->
            if err
              callback 500
            hash['latest_time'] = message.timestamp.getTime()
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
        ..json conversationList

apiRouter.get '/participants/', (req, res) ->
  conversationDAO.getParticipants req.query.conversation_id, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

module.exports = apiRouter
