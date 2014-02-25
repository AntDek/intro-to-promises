Promise = require '../02-promises/promise'

Array.prototype.toAsync = ->
	promise = new Promise()
	failed = false

	length = this.length
	acc = []
	
	onDone = (index) -> (data) ->
		return if failed
		acc[index] = data
		promise.onNext acc if --length is 0

	onFail = (err) ->
		failed = true
		promise.onFail err
	
	this.forEach (promise, index) ->
		promise.done onDone index
		promise.fail onFail
	
	promise

Array.prototype.toSync = ->
	promise = new Promise()
	promises = this
	acc = []
	
	doNext = (index, length) ->
		number = promises[index]
		number.done (value) ->
			acc.push value

			if index < length
				doNext ++index, length
			else
				promise.onNext acc
	doNext 0, this.length - 1
	promise

futureNumber = (number) ->
	promise = new Promise()
	process.nextTick ->
		promise.onNext number
	promise

[
	futureNumber 1
	futureNumber 2
	futureNumber 3
	futureNumber 4
].toSync().done console.log 
