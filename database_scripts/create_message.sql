CREATE TABLE MESSAGES(
    conversation_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    text TEXT,
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL
);

