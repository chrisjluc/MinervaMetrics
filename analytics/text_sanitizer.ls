removePunctuation = (text) ->
  # Doesn't exclude apostrophes
  text = text.replace /[.,\/#!"$?%\^&\*;:{}=\-_`~()]/g ''
  return text

stopWords = new Set ['a' 'about' 'above' 'across' 'after' 'afterwards' 'again' 'against' 'all' 'almost' 'alone'
'along' 'already' 'also' 'although' 'always' 'am' 'among' 'amongst' 'amoungst' 'amount'  'an' 'and' 'another' 'any'
'anyhow' 'anyone' 'anything' 'anyway' 'anywhere' 'are' 'around' 'as'  'at' 'back' 'be' 'became' 'because' 'become'
'becomes' 'becoming' 'been' 'before' 'beforehand' 'behind' 'being' 'below' 'beside' 'besides' 'between' 'beyond' 'bill'
'both' 'bottom' 'but' 'by' 'call' 'can' 'cannot' 'cant' 'co' 'con' 'could' 'couldnt' 'cry' 'de' 'describe' 'detail' 'do'
'done' 'down' 'due' 'during' 'each' 'eg' 'eight' 'either' 'eleven' 'else' 'elsewhere' 'empty' 'enough' 'etc' 'even'
'ever' 'every' 'everyone' 'everything' 'everywhere' 'except' 'few' 'fifteen' 'fify' 'fill' 'find' 'fire' 'first' 'five'
'for' 'former' 'formerly' 'forty' 'found' 'four' 'from' 'front' 'full' 'further' 'get' 'give' 'go' 'had' 'has' 'hasnt'
'have' 'he' 'hence' 'her' 'here' 'hereafter' 'hereby' 'herein' 'hereupon' 'hers' 'herself' 'him' 'himself' 'his' 'how'
'however' 'hundred' 'ie' 'if' 'in' 'inc' 'indeed' 'interest' 'into' 'is' 'it' 'its' 'itself' 'keep' 'last' 'latter'
'latterly' 'least' 'less' 'ltd' 'made' 'many' 'may' 'me' 'meanwhile' 'might' 'mill' 'mine' 'more' 'moreover' 'most'
'mostly' 'move' 'much' 'must' 'my' 'myself' 'name' 'namely' 'neither' 'never' 'nevertheless' 'next' 'nine' 'no'
'nobody' 'none' 'noone' 'nor' 'not' 'nothing' 'now' 'nowhere' 'of' 'off' 'often' 'on' 'once' 'one' 'only' 'onto'
'or' 'other' 'others' 'otherwise' 'our' 'ours' 'ourselves' 'out' 'over' 'own' 'part' 'per' 'perhaps' 'please' 'put'
'rather' 're' 'same' 'see' 'seem' 'seemed' 'seeming' 'seems' 'serious' 'several' 'she' 'should' 'show' 'side'
'since' 'sincere' 'six' 'sixty' 'so' 'some' 'somehow' 'someone' 'something' 'sometime' 'sometimes' 'somewhere'
'still' 'such' 'system' 'take' 'ten' 'than' 'that' 'the' 'their' 'them' 'themselves' 'then' 'thence' 'there'
'thereafter' 'thereby' 'therefore' 'therein' 'thereupon' 'these' 'they' 'thickv' 'thin' 'third' 'this' 'those'
'though' 'three' 'through' 'throughout' 'thru' 'thus' 'to' 'together' 'too' 'top' 'toward' 'towards' 'twelve'
'twenty' 'two' 'un' 'under' 'until' 'up' 'upon' 'us' 'very' 'via' 'was' 'we' 'well' 'were' 'what' 'whatever' 'when'
'whence' 'whenever' 'where' 'whereafter' 'whereas' 'whereby' 'wherein' 'whereupon' 'wherever' 'whether' 'which'
'while' 'whither' 'who' 'whoever' 'whole' 'whom' 'whose' 'why' 'will' 'with' 'within' 'without' 'would' 'yet' 'you'
'your' 'yours' 'yourself' 'yourselves' 'the', 'like', 'yeah', 'just', 'okay', 'think', 'it\'s', 'good', 'want', 'sure',
'coming', 'right', 'left', 'come', 'need', 'did', 'does', 'maybe', 'don\'t', 'let', 'wait', 'things', 'new', 'nope',
'i\'m', 'going', 'know', 'didn\'t', 'lot', 'that\'s', 'say', 'doesn\'t', 'yea', 'i\'ll', 'you\'re', 'cause', 'soon',
'there\'s', 'he\'s', 'she\'s', 'doing', 'can\'t', 'they\'re', 'got', 'im', 'dont', 'having', 'meet', 'told', 'said',
'oh', 'ya']

removeStopWords = (words) ->
  [word for let word in words when !stopWords.has word]

removeSingleLetterWords = (words) ->
  [word for let word in words when word.length > 1]

module.exports =
  removePunctuation: removePunctuation
  removeStopWords: removeStopWords
  removeSingleLetterWords: removeSingleLetterWords
