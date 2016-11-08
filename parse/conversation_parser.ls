conversationDAO = require '../daos/conversation_dao'
https = require './https'
options = require './options'

module.exports =
  parseConversation: (authToken) ->
    inboxOption = options.getInboxOptions authToken

    https.get inboxOption, (res) ->
      for conversation in res.data
        participants = [[participant.id, participant.name] for participant in conversation.to.data]
        userConversations = [[conversation.id, participant.id] for participant in conversation.to.data]
        conversationDAO.createParticipants participants, (err) ->
          if !err
            conversationDAO.createConversation conversation.id, (err) ->
              if !err
                conversationDAO.createUserConversations userConversations, null
