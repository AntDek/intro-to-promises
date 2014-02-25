sleep = require 'sleep'

process.on 'message', (message)->
	sleep.sleep 1
	process.send 'Workder done with message:' + message