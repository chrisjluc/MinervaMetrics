require! livescript
require! https

args = process.argv.slice 2;
convoID = args[0]
access_token = args[1]

p = '/v2.3/#convoID?fields=to%2Ccomments.limit(1000)&access_token=#access_token'

options = 
  host: 'graph.facebook.com'
  path: p
  method: 'GET'

convo = []
threads_parsed = 0

getTestPersonaLoginCredentials = (callback, options) ->

    https.get options, (response) ->
        body = ''
        response.on 'data' d -> 
            body += d
        response.on 'end' ->
            parsed = JSON.parse body
            if parsed.error
                console.log parsed.error
            else
                callback(parsed);
            
        


callback_fn = (parsed) ->
    for comment in parsed.comments.data
        sender = comment.from.id
        message = 
            sender_id: sender
            thread_id: convoID
            text: comment.message
            timestamp: comment.created_time

        convo.push message
	
    console.log convo.length
    options = parsed.comments.paging.next

for i in 1 to 10 by 1
    getTestPersonaLoginCredentials callback_fn options


