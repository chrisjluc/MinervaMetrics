CREATE TABLE facebook_user(
    user_id BIGINT NOT NULL PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

INSERT INTO facebook_user VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Dave')
