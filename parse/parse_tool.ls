require! https
messageDAO = require '../daos/message_dao'
conversationDAO = require '../daos/conversation_dao'

i = 0
numberOfConversations = 1
thread_limit = 5

messages = []

insertMessageToDatabase = (messages) ->
  for message in messages
    messageDAO.postMessages message, (err) ->
      if err
        return err



insertParticipantToDatabase = (participants,authToken,convoID) ->

  console.log(participants)
  messageOptions = 
    host: 'graph.facebook.com'
    path: '/v2.3/' + convoID + '/comments?limit=1000&access_token=' + authToken
    method: 'GET'


  createUserConversationsCallback = (err) ->
    if err
      return err
    else
      console.log("createUserConversationsCallback")
      httpCall parseMessages, messageOptions, convoID
  
  createConversationsCallback = (err) ->
    if err
      return err
    else
      console.log("createConversationsCallback")
      conversationDAO.createUserConversations participants, createUserConversationsCallback

  createParticipantsCallback = (err) ->
    if err
      return err
    else 
      console.log("createParticipantsCallback")
      conversationDAO.createConversations [convoID], createConversationsCallback


  conversationDAO.createParticipants participants, createParticipantsCallback


httpCall = (callback, options, param) ->
  https.get options, (response) ->
    body = ''
    response.on 'data', (d) -> 
      body += d
    response.on 'end', ->
      parsed = JSON.parse body
      if parsed.error
          console.log parsed.error
      else
        callback parsed, param
            

getConversations = (parsed,authToken) ->
  for conversation in parsed.data
    convoID = conversation.id
    participants = []
    for participant in conversation.to.data
      participants.push [Number(convoID),Number(participant.id),participant.name]
    console.log("==============================================================================")
    insertParticipantToDatabase(participants,authToken,convoID)

parseMessages = (parsed,convoID) ->
  console.log(parsed.data.length)
  console.log(messages[*-1])
  if parsed.data.length == 0 or i > thread_limit
    err = true
    console.log("end")
    insertMessageToDatabase messages
    return

  for comment in parsed.data
    sender = comment.from.id
    message = [
      comment.id
      Number(convoID)
      Number(sender)
      comment.message
      comment.created_time
    ]
    messages.push message

  i += 1
  httpCall parseMessages, parsed.paging.next, convoID

parseConversation = (authToken) ->
  inboxOption = 
    host: 'graph.facebook.com'
    path: '/v2.3/me/inbox?fields=to&limit=' + numberOfConversations + '&access_token=' + authToken
    method: 'GET'

  httpCall getConversations, inboxOption, authToken

module.exports =
  parseConversation: parseConversation
