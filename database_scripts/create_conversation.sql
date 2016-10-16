CREATE TABLE conversation(
    conversation_id BIGINT NOT NULL PRIMARY KEY,
);

CREATE TABLE conversation_user(
    conversation_id BIGINT NOT NULL REFERENCES conversation(conversation_id),
    user_id BIGINT NOT NULL REFERENCES user(user_id)
    CONSTRAINT u_constraint_conversation_user UNIQUE (conversation_id, user_id)
);
