sleep = require 'sleep'

slowOperation = (message, done) ->
	sleep.sleep 2
	done null, 'slowOperation processed message: ' + message

nextOperation = (message, done) ->
	sleep.sleep 1
	done 'nextOperation feild on message: ' + message

message = 'Hello world'
slowOperation message, (err, res) ->
	console.log err if err
	console.log res if res

nextOperation message, (err, res) ->
	console.log err if err
	console.log res if res