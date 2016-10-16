require! express

server = require '../server/server'
apiRouter = express.Router!

apiRouter.get '/analytics', (req, res) ->
  res.status 200
    ..json analytics: 'works!'

apiRouter.post '/messages', server.postMessage

apiRouter.get '/messages/', server.getMessages

module.exports = apiRouter
