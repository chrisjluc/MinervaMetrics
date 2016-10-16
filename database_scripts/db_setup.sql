DROP DATABASE IF EXISTS minerva;
CREATE DATABASE minerva WITH ENCODING 'UTF8';

\c minerva;
\i database_scripts/create_metrics.sql
\i database_scripts/create_user.sql
\i database_scripts/create_conversation.sql
\i database_scripts/create_message.sql

DROP USER IF EXISTS server;
CREATE USER server;
ALTER USER server WITH PASSWORD '';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to server;
