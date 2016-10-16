require! express

mainRouter = express.Router!

mainRouter.get '/*', (req, res, next) ->
  res.render 'main'

module.exports = mainRouter
