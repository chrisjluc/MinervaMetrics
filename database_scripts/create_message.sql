CREATE TABLE message(
    message_id VARCHAR(40) NOT NULL PRIMARY KEY,
    conversation_id BIGINT NOT NULL REFERENCES conversation(conversation_id),
    sender_id BIGINT NOT NULL,
    text TEXT,
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL
);

INSERT INTO message VALUES
('1', 1, 1, 'hello this is a test message', now()),
('2', 1, 1, 'hello this is another message', now() - interval '1 hour'),
('3', 1, 1, 'test i am user 2', now() - interval '2 hour'),
('4', 1, 1, 'test i am user 2', now() - interval '2 hour'),
('5', 1, 2, 'test i am user 2', now() - interval '3 hour'),
('6', 1, 2, 'test i am user 2', now() - interval '4 hour')
