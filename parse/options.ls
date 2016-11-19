host = 'graph.facebook.com'
version = '/v2.3/'

module.exports =
  getMessageOptions: (conversationId, authToken) ->
    options =
      host: host
      path: version + conversationId + '/comments?access_token=' + authToken

  getInboxOptions: (authToken) ->
    options =
      host: host
      path: version + 'me/inbox?fields=to,updated_time&limit=50&access_token=' + authToken
