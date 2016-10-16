const pg = require('pg');
const path = require('path');
const connectionString = process.env.DATABASE_URL || 'postgres://localhost:5432/minerva';

function getMessages(req, res, next) {
  results = [];
  // Get a Postgres client from the connection pool
  pg.connect(connectionString, (err, client, done) => {
    // Handle connection errors
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({success: false, data: err});
    }

    const query = client.query('SELECT text, sender_id, timestamp FROM messages WHERE conversation_id = $1', [req.query.conversation_id]);
    // Stream results back one row at a time
    query.on('row', (row) => {
      results.push(row);
    });
    // After all data is returned, close connection and return results
    query.on('end', () => {
      done();
      return res.json(results);
    });
  });
}

function postMessage(req, res, next) {
  const data = {conversation_id: req.body.conversation_id, sender_id: req.body.sender_id, text: req.body.text, timestamp: req.body.timestamp};
  // Get a Postgres client from the connection pool
  pg.connect(connectionString, (err, client, done) => {
    // Handle connection errors
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({success: false, data: err});
    }
    // SQL Query > Insert Data
    const query = client.query('INSERT INTO messages(conversation_id, sender_id, text, timestamp) values($1, $2, $3, $4)',
    [data.conversation_id, data.sender_id, data.text, data.timestamp]);

    // Close connection and return results
    query.on('end', () => {
      done();
      return res.status(200).json({success: true});
    });
  });
}

module.exports = {
  getMessages: getMessages,
  postMessage: postMessage
};
