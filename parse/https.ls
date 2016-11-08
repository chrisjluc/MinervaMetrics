require! https

module.exports =
  get: (callback, options) ->
    https.get options, (response) ->
      data = ''
      response.on 'data', (d) ->
        data += d
      response.on 'end', ->
        json = JSON.parse data
        if json.error
          console.log json.error
        else
          callback json
