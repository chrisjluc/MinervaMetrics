require! express

server = require '../server/server'
apiRouter = express.Router!
analytics = require '../analytics/analytics'

apiRouter.get '/analytics', (req, res) ->
  analytics.topWords 1
  res.status 200
    ..json analytics: 'works!'

apiRouter.post '/messages', server.postMessage

apiRouter.get '/messages/', server.getMessages

module.exports = apiRouter
