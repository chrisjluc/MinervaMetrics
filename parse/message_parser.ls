messageDAO = require '../daos/message_dao'
https = require './https'
options = require './options'

threadLimit = 5
i = 0 

createMessages = (messages) ->
  for message in messages
    messageDAO.saveMessages message, null

fetchMessages = (messageOption, conversationId) ->
  https.get messageOption, (err, res) ->
    if err
      console.log err
      return
    if res.data.length == 0 or i > threadLimit
      console.log "end"
      return

    messages = [[m.id, conversationId, m.from.id, m.message, m.created_time] for m in res.data]
    createMessages messages
    i += 1
    fetchMessages res.paging.next, conversationId

module.exports =
  parseMessages: (authToken,conversationId) ->
    messageOption = options.getMessageOptions authToken, conversationId
    fetchMessages messageOption, conversationId

  parseMessagesSince: (authToken,conversationId,lastUpdatedTime) ->
    messageOption = options.getMessageSinceOptions authToken, conversationId, lastUpdatedTime
    fetchMessages messageOption, conversationId
