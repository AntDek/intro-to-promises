Event = require('events').EventEmitter
sleep = require 'sleep'

slowOperation = do ->
	event = new Event()
	event.on 'message', (message) ->
		sleep.sleep 1
		event.emit 'done', 'slowOperation processed message: ' + message
	event


nextOperation = do ->
	event = new Event()
	event.on 'message', (message) ->
		event.emit 'fail', 'nextOperation feild on message: ' + message
	event

message = 'Hello world!'
slowOperation
	.on 'done', console.log
	.emit 'message', message

nextOperation
	.on 'fail', console.log
	.emit 'message', message