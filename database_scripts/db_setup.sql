DROP DATABASE IF EXISTS minerva;
CREATE DATABASE minerva WITH ENCODING 'UTF8';

\c minerva;
\i database_scripts/create_message.sql
\i database_scripts/create_metrics.sql

CREATE USER server;
ALTER USER server WITH PASSWORD '';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to server;
