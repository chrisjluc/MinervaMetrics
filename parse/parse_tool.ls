require! https
messageDAO = require '../daos/message_dao'

args = process.argv.slice 2
accessToken = args[0]

i = 0
numberOfConversations = 1
thread_limit = 5

convoID = ""

inboxOption = 
  host: 'graph.facebook.com'
  path: '/v2.3/me/inbox?fields=message&limit=' + numberOfConversations + '&access_token=' + accessToken
  method: 'GET'

convo = []
participants = []

insertMessageToDatabase = (convo) ->
  for message in convo
    messageDAO.postMessages message, null


insertParticipantToDatabase = (participants) ->
  return

httpCall = (callback, options) ->
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
    participants.push user
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

httpCall getConversations, inboxOption

