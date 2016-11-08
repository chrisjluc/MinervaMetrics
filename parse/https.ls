require! https

module.exports =
  get: (options, callback) ->
    https.get options, (response) ->
      data = ''
      response.on 'data', (d) ->
        data += d
      response.on 'end', ->
        json = JSON.parse data
        if json.error
          callback json.error, null
        else
          callback null, json
