express = require('express')
app = express()
http = require('http').Server(app)
io = require('socket.io')(http)
path = require('path')

app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) -> 
	res.sendFile("#{__dirname}\/public\/index.html")
)

io.on('connection', (socket) ->
	clientIp = socket.request.connection.remoteAddress
	console.log(clientIp)

	socket.join(clientIp)
	
	socket.on('disconnect', ->
		console.log('user disconnected')
	)
	
	socket.on('set-background', (hexColor) ->
		io.to(clientIp).emit('update-background', hexColor)
#		io.sockets.emit('update-background', hexColor)
	)
)

http.listen(3000, ->
	console.log('listening on *:3000') 
)