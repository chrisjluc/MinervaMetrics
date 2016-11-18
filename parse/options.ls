host = 'graph.facebook.com'
version = '/v2.3/'

module.exports =
  getMessageOptions: (authToken, conversationId) ->
    options =
      host: host
      path: version + conversationId + '/comments?access_token=' + authToken

  getMessageSinceOptions: (authToken, conversationId, lastUpdatedTime) ->
    options =
      host: host
      path: version + conversationId + '/comments?since=' + Date.parse(lastUpdatedTime)/1000  +'access_token=' + authToken

  getInboxOptions: (authToken) ->
    options =
      host: host
      path: version + 'me/inbox?fields=to,updated_time&limit=50&access_token=' + authToken
