conversationDAO = require '../daos/conversation_dao'
https = require './https'
options = require './options'


createConversationMetaData = (conversation) ->
  participants = [[participant.id, participant.name] for participant in conversation.to.data]
  userConversations = [[conversation.id, participant.id] for participant in conversation.to.data]
  conversationDAO.createParticipants participants, (err) ->
    if !err
      conversationDAO.createConversation [conversation.id,conversation.updated_time], (err) ->
        if !err
          conversationDAO.createUserConversations userConversations, null

module.exports =
  parseConversation: (authToken) ->
    inboxOption = options.getInboxOptions authToken

    https.get inboxOption, (err, res) ->
      if err
        console.log err
        return

      for conversation in res.data
        createConversationMetaData conversation

