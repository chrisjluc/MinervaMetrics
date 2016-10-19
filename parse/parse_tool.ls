require! https
messageDAO = require '../daos/message_dao'
conversationDAO = require '../daos/conversation_dao'

i = 0
numberOfConversations = 1
thread_limit = 5

convoID = ""

accessToken = ""

convo = []
participants = []

insertMessageToDatabase = (convo) ->
  for message in convo
    messageDAO.postMessages message, null


insertParticipantToDatabase = (participants) ->
  for participant in participants
    conversationDAO.postParticipants participant, null

httpCall = (callback, options,authToken) ->
  https.get options, (response) ->
    body = ''
    response.on 'data', (d) -> 
      body += d
    response.on 'end', ->
      parsed = JSON.parse body
      if parsed.error
          console.log parsed.error
      else
        callback parsed
            

getConversations = (parsed) ->
  for conversation in parsed.data
    convoID = conversation.id

    messageOptions = 
      host: 'graph.facebook.com'
      path: '/v2.3/' + convoID + '/comments?limit=1000&access_token=' + accessToken
      method: 'GET'

    participantOptions = 
      host: 'graph.facebook.com'
      path: '/v2.3/' + convoID + '?fields=to&access_token=' + accessToken
      method: 'GET'

    httpCall parseParticipants, participantOptions
    httpCall parseMessages, messageOptions

parseParticipants = (parsed) ->
  console.log(parsed.to.data.length)
  for user in parsed.to.data
    participants.push [convoID,user]
  console.log participants
  insertMessageToDatabase(participants)

parseMessages = (parsed) ->
  console.log(parsed.data.length)

  if parsed.data.length == 0 or i > thread_limit
    err = true
    console.log("end")
    insertMessageToDatabase convo
    return

  for comment in parsed.data
    sender = comment.from.id
    message = [
      comment.id
      convoID
      sender
      comment.message
      comment.createdTime
    ]
    convo.push message

  console.log convo.length
  console.log convo[convo.length - 1]
  i += 1
  httpCall parseMessages, parsed.paging.next

parseConversation = (authToken) ->
  accessToken = authToken
  inboxOption = 
    host: 'graph.facebook.com'
    path: '/v2.3/me/inbox?fields=message&limit=' + numberOfConversations + '&access_token=' + accessToken
    method: 'GET'

  httpCall getConversations, inboxOption

module.exports =
  parseConversation: parseConversation
