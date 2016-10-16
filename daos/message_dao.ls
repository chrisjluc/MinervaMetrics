getMessages = (conversationId) ->
  [
  * text: 'hello hello hello how how are you?'
    sender_id: 1
    timestamp: Date.now() - 1
  * text: 'hello, i\'m good your self?'
    sender_id: 2
    timestamp: Date.now() - 10
  * text: 'Hello hello Yeah, I\m fine as well! I can not believe he is "good"'
    sender_id: 1
    timestamp: Date.now()
  ]

module.exports =
  getMessages: getMessages
