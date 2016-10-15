DROP DATABASE IF EXISTS minerva;
CREATE DATABASE minerva WITH ENCODING 'UTF8';

\c minerva;

CREATE TABLE MESSAGE(
    text TEXT,
    sender_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    time TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE USER server;
ALTER USER server WITH PASSWORD '';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to server;