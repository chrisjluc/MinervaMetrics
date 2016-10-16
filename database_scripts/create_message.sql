CREATE TABLE message(
    message_id CHAR(26) NOT NULL PRIMARY KEY,
    conversation_id BIGINT NOT NULL REFERENCES conversation(conversation_id),
    sender_id BIGINT NOT NULL,
    text TEXT,
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL
);
