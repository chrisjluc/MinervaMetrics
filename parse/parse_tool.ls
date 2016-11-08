conversationDAO = require '../daos/conversation_dao'
https = require './https'
options = require './options'

insertParticipantToDatabase = (participants, userConversations, authToken, convoID) ->
  conversationDAO.createParticipants participants, (err) ->
    if !err
      conversationDAO.createConversations convoID, (err) ->
        if !err
          conversationDAO.createUserConversations userConversations, null


saveConversations = (authToken) ->
  return (res) ->
    for conversation in res.data
      convoID = conversation.id

      participants = []
      userConversations = []

      for participant in conversation.to.data
        participants.push [
          participant.id
          participant.name
        ]
        userConversations.push [
          convoID
          participant.id
        ]

      insertParticipantToDatabase participants,userConversations,authToken,convoID

parseConversation = (authToken) ->
  inboxOption = options.getInboxOptions authToken
  https.get (saveConversations authToken), inboxOption

module.exports =
  parseConversation: parseConversation
