require! express

apiRouter = express.Router!

apiRouter.get '/analytics', (req, res) ->
  res.status 200
    ..json analytics: 'works!'

module.exports = apiRouter
