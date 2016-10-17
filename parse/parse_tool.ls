require! https
messageDAO = require '../daos/message_dao'

args = process.argv.slice 2
access_token = args[0]

i = 0
number_of_conversations = 1
thread_limit = 5

convoID = ""

get_inbox_option = 
  host: 'graph.facebook.com'
  path: '/v2.3/me/inbox?fields=message&limit=' + number_of_conversations + '&access_token=' + access_token
  method: 'GET'

convo = []
participants = []
err = false

insertMessageToDatabase = (convo) ->
  for message in convo
    messageDAO.getMessages message, null


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
          err = true
      else
        callback parsed
            

getConversations = (parsed) ->
  for conversation in parsed.data
    convoID = conversation.id

    get_message_options = 
      host: 'graph.facebook.com'
      path: '/v2.3/' + convoID + '/comments?limit=1000&access_token=' + access_token
      method: 'GET'

    get_participant_options = 
      host: 'graph.facebook.com'
      path: '/v2.3/' + convoID + '?fields=to&access_token=' + access_token
      method: 'GET'

    httpCall parseParticipants, get_participant_options
    httpCall parseMessages, get_message_options

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
      comment.created_time
    ]
    convo.push message

  console.log convo.length
  console.log convo[convo.length - 1]
  i += 1
  httpCall parseMessages, parsed.paging.next

httpCall getConversations, get_inbox_option

