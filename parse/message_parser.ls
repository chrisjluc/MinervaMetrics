messageDAO = require '../daos/message_dao'
https = require './https'
options = require './options'

const numThreads = 200

createMessages = (messages) ->
  for message in messages
    messageDAO.saveMessages message, null

fetchMessages = (messageOption, conversationId, threadCount) ->
  if threadCount <= 0
    console.log "end"
    return

  https.get messageOption, (err, res) ->
    if err
      console.log err
      return
    if res.data.length == 0
      console.log "end"
      return

    messages = [[m.id, conversationId, m.from.id, m.message, m.created_time] for m in res.data]
    createMessages messages
    fetchMessages res.paging.next, conversationId, (threadCount - 1)

module.exports =
  parseMessages: (authToken, conversationId) ->
    messageOption = options.getMessageOptions authToken, conversationId
    fetchMessages messageOption, conversationId, numThreads

  parseMessagesSince: (authToken, conversationId, lastUpdatedTime) ->
    messageOption = options.getMessageSinceOptions authToken, conversationId, lastUpdatedTime
    fetchMessages messageOption, conversationId, numThreads
