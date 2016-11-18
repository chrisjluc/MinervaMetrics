CREATE TABLE conversation(
   conversation_id BIGINT NOT NULL PRIMARY KEY,
   last_updated_time TIMESTAMP WITH TIME ZONE NOT NULL,
   has_new_messages boolean DEFAULT TRUE NOT NULL 
);

CREATE TABLE user_conversation(
    conversation_id BIGINT NOT NULL REFERENCES conversation(conversation_id),
    user_id BIGINT NOT NULL REFERENCES facebook_user(user_id),
    CONSTRAINT u_constraint_conversation_user UNIQUE (conversation_id, user_id)
);

INSERT INTO conversation VALUES
(1,'2016-11-17T03:21:08+0000'),
(2,'2016-11-17T03:21:08+0000');

INSERT INTO user_conversation VALUES
(1, 1),
(1, 2)
