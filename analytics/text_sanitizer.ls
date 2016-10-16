removePunctuation = (text) ->
  # Doesn't exclude apostrophes
  text = text.replace /[.,\/#!"$?%\^&\*;:{}=\-_`~()]/g ''
  return text

module.exports =
  removePunctuation: removePunctuation
