Promise = require('events').EventEmitter

Promise.prototype.done = (data) ->
	this.on 'done', data
Promise.prototype.fail = (data) ->
	this.on 'fail', data

Promise.prototype.onNext = (data) ->
	this.emit 'done', data
Promise.prototype.onError = (data) ->
	this.emit 'fail', data

module.exports = Promise