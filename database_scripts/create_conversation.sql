CREATE TABLE conversation(
    conversation_id BIGINT NOT NULL PRIMARY KEY
);

CREATE TABLE user_conversation(
    conversation_id BIGINT NOT NULL REFERENCES conversation(conversation_id),
    user_id BIGINT NOT NULL REFERENCES facebook_user(user_id),
    CONSTRAINT u_constraint_conversation_user UNIQUE (conversation_id, user_id)
);
