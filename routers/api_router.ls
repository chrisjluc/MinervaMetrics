require! express
messageDAO = require '../daos/message_dao'

server = require '../server/server'
apiRouter = express.Router!
analytics = require '../analytics/analytics'

apiRouter.get '/analytics', (req, res) ->
  analytics.topWords 1
  res.status 200
    ..json analytics: 'works!'

apiRouter.post '/messages', server.postMessages

apiRouter.get '/messages/', (req, res) ->
  messageDAO.getMessages req.query.conversation_id, (err, result) ->
    if err
      return (res.status 500).json success: false
    res.status 200
      ..json result

module.exports = apiRouter
