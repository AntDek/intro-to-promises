cluster = require 'cluster'
jayson = require 'jayson'
sleep = require 'sleep'
Promise = require '../02-promises/promise'

if (cluster.isMaster)

	# Start workers and listen for messages containing notifyRequest
	numCPUs = 3
	for i in [1..numCPUs]
		cluster.fork()


else
	server = jayson.server
		read: (msg, time, done) ->
			console.log 'processed by worker #' + cluster.worker.id

			sleep.sleep time
			done null, "Reader read the message: #{msg} in #{time} seconds"

	server.tcp().listen 3000, ->
		console.log "Worker ##{cluster.worker.id} is listening on port 3000"