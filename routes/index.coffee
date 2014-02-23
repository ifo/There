r = require 'rethinkdb'

connection = null
r.connect
  host: process.env.RETHINKDB_HOST
  port: process.env.RETHINKDB_PORT
  authKey: process.env.RETHINKDB_AUTH
  (err, conn) ->
    throw err  if err
    connection = conn

# Routes
module.exports =
  index: (req, res) ->
    res.send 'You are Here :)<br /><br />- There'
    return

  home: (req, res) ->
    r.table 'reminders'
      .getAll req.params.streetName, index: 'thoroughfare'
      .filter r.row('postalCode').eq req.params.zip
      .filter r.row('subThoroughfareRangeStart').le parseInt req.params.streetAddress
      .filter r.row('subThoroughfareRangeEnd').ge parseInt req.params.streetAddress
      .run connection, (err, cursor) ->
        throw err  if err
        cursor.toArray (err, result) ->
          throw err  if err
          res.json result
    return

  car: (req, res) ->
    r.table 'reminders'
      .getAll req.params.streetName, index: 'thoroughfare'
      .filter r.row('postalCode').eq req.params.zip
      .filter r.row('subThoroughfareRangeStart').le req.params.streetAddress
      .filter r.row('subThoroughfareRangeEnd').ge req.params.streetAddress
      .run connection, (err, cursor) ->
        throw err  if err
        cursor.toArray (err, result) ->
          throw err  if err
          res.json result
    return
