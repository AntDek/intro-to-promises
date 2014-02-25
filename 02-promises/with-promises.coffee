sleep = require 'sleep'
Promise = require('events').EventEmitter

promise.prototype.done = (data) ->
	this.on 'done', data
promise.prototype.fail = (data) ->
	this.on 'fail', data

promise.prototype.onNext = (data) ->
	this.emit 'done', data
promise.prototype.onError = (data) ->
	this.emit 'fail', data

slowOperation = (message) ->
	promise = new Promise();
	process.nextTick ->
		sleep.sleep 2
		promise.onNext 'slowOperation processed message: ' + message
	promise


nextOperation = (message) ->
	promise = new Promise();
	process.nextTick ->
		sleep.sleep 1
		promise.onError 'nextOperation feild on message: ' + message
	promise

message = 'Hello world!'
slowOperation(message).done console.log  
nextOperation(message).fail console.log