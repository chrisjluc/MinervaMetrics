CREATE TABLE wordcount(
    id BIGINT NOT NULL PRIMARY KEY,
    conversation_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    word VARCHAR(255) NOT NULL,
    count BIGINT
);
