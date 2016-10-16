pg = require 'pg'

config =
  user: 'server'
  database: 'minerva'
  host: 'localhost'
  port: 5432
  max: 10
  idleTimeoutMillis: 30000

pool = new pg.Pool config

pool.on 'error', (err, client) ->
  console.error 'idle client error', err.message, err.stack
  return

acquireClient = (callback) ->
  pool.connect callback

module.exports =
  acquireClient: acquireClient

