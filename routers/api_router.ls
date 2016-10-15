require! express

apiRouter = express.Router!
analytics = require '../analytics/analytics'

apiRouter.get '/analytics', (req, res) ->
  analytics.topWords 1
  res.status 200
    ..json analytics: 'works!'

module.exports = apiRouter
