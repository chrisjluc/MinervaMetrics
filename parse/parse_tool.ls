require! https

args = process.argv.slice 2
convoID = 211777115666079
access_token = args[0]

i = 0

p = '/v2.3/' + convoID + '/comments?limit=1000&access_token=' + access_token

options = 
  host: 'graph.facebook.com'
  path: p
  method: 'GET'

convo = []
err = false

getTestPersonaLoginCredentials = (callback, options) ->
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
            
        
insertMessageToDatabase = (array) ->
  for message in array
    o = 
      host: 'localhost:8000'
      path: '/api/messages/'
      method: 'POST'
      data: message

    https.request o (res) ->
      res.setEncoding 'utf8'
      res.on 'data', (chunk) ->
          console.log 'Response: ' + chunk 

callback_fn = (parsed) ->
  console.log(parsed.data.length)

  if parsed.data.length == 0 or i > 2
    err = true
    console.log("end")
    insertMessageToDatabase convo
    return

  for comment in parsed.data
    sender = comment.from.id
    message = 
      message_id = comment.id
      text: comment.message
      sender_id: sender
      conversation_id: convoID
      timestamp: comment.created_time

    convo.push message

  console.log convo.length
  console.log convo[convo.length - 1]
  getTestPersonaLoginCredentials callback_fn, parsed.paging.next

getTestPersonaLoginCredentials callback_fn, options


