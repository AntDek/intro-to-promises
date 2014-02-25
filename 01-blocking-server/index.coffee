express = require 'express'
sleep = require 'sleep'

app = express()

app.post '/fast', (req, res) ->
	res.send 'fast operation done'

app.post '/slow', (req, res) ->
	process.nextTick ->
		sleep.sleep 1
		res.send 'slow operation done'

app.listen 8080
console.log 'Listening on port 8080'