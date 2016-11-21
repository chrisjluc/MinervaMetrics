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
('3', 1, 1, 'wait a sec im so busy rn. jeez.', now() - interval '2 hour'),
('4', 1, 1, 'i love waterloo', now() - interval '2 hour'),
('5', 1, 2, 'this is an awesome application', now() - interval '3 hour'),
('6', 1, 2, 'I AM GREAT... ALEX THE GREAT', now() - interval '4 hour'),
('7', 1, 1, 'where is the love? WHERE IS IT?', now() - interval '1 day'),
('8', 1, 2, 'i hate you', now() - interval '1 day'),
('9', 1, 2, 'hi hi hi hi i miss you hi i love you', now() - interval '2 day'),
('10', 1, 1, 'hey, wtf? what the hell? this is awesome!', now() - interval '2 day'),
('11', 1, 1, 'thank you you are amazing', now() - interval '2 day'),
('12', 1, 1, 'nothing is as awesome as you', now() - interval '2 month'),
('13', 2, 1, 'hey, wtf? what the hell? this is awesome!', now() - interval '2 day'),
('14', 2, 1, 'thank you you are amazing', now() - interval '2 day'),
('15', 2, 1, 'nothing is as awesome as you', now() - interval '2 month')
