request = require 'superagent'

request
	.post 'http://localhost:8080/slow'
	.end (err, res) ->
		console.log res.text


for i in [0..10]
	request
		.post 'http://localhost:8080/fast'
		.end (err, res) ->
			console.log res.text

