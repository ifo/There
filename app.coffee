
###
Module dependencies.
###
express = require('express')
routes = require('./routes')
http = require('http')
path = require('path')
app = express()

# all environments
app.set 'port', process.env.PORT or 3000
app.use express.favicon(__dirname + '/favicon.png')
app.use express.logger('dev')
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router

# development only
app.use express.errorHandler()  if 'development' is app.get('env')

app.get '/', routes.index
app.get '/:zip/:streetName/reminders/home', routes.home
app.get '/:zip/:streetName/reminders/car', routes.car

http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')
  return

