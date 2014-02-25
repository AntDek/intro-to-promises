Promise = require './promise'
worker = require('child_process').fork './worker'

slowOperation = (post) ->
	promise = new Promise();
	worker.on 'message', (post) -> promise.onNext post
	worker.on 'message', -> worker.kill()
	worker.send	post
	promise


nextOperation = (message) ->
	promise = new Promise();
	process.nextTick ->
		promise.onNext 'NextOperation done with message: ' + message
	promise

message = 'Hello world!'
slowOperation(message).done console.log
nextOperation(message).done console.log