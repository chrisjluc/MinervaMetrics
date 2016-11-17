require! express
conversationParser = require '../parse/conversation_parser'
topWordsAnalytics = require '../analytics/top_words'
conversationDAO = require '../daos/conversation_dao'
messageDAO = require '../daos/message_dao'
messageCountDAO = require '../daos/message_count_dao'
messageCountAnalytics = require '../analytics/message_count'

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
    conversationsLeft = conversations.length
    for conversation in conversations
      ((id) ->
        hash = {'conversation_id': id}
        conversationDAO.getHasUpdates id, (err, hasUpdates) ->
          if err
            return res.status 500 .json success: false
          hash['has_updates'] = hasUpdates
          conversationDAO.getParticipants id, (err, participants) ->
            if err
              return res.status 500 .json success: false
            hash['participants'] = participants
            messageDAO.getMostRecentMessage id, (err, message) ->
              if err
                return res.status 500 .json success: false
              hash['latest_time'] = message.timestamp.getTime()
              messageCountDAO.getTotalMessageCount id, (err, count) ->
                if err
                  return res.status 500 .json success: false
                hash['count'] = count[0]['count']
                conversationList.push(hash)
                if --conversationsLeft == 0
                  res.status 200
                    ..json conversationList
      ) conversation.conversation_id

apiRouter.get '/participants/', (req, res) ->
  conversationDAO.getParticipants req.query.conversation_id, (err, result) ->
    if err
      return res.status 500 .json success: false
    res.status 200
      ..json result

module.exports = apiRouter
