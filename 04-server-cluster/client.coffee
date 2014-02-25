jayson = require 'jayson'
Promise = require '../02-promises/promise'

Array.prototype.asyncEach = (func) ->
	response = new Promise()
	length = this.length
	this.forEach (promise, index) ->
		promise.done (data) ->
			func data
			response.onNext() if --length is 0
	response

client = jayson.client.tcp({ port: 3000, host: 'localhost' })

callReader = (msg, time) ->
	promise = new Promise();
	client.request 'read', [msg, time], (err, reply) ->
		promise.onNext reply.result
	promise

started = new Date()
[
	callReader 'Hello reader!', 3
	callReader 'I am fast!', 1
	callReader 'I am fast!', 2
].asyncEach(console.log).done ->
	finished = new Date()
	console.log "done in #{finished - started} ms"