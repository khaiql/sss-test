getForegroundColor = (bgHexColor) ->
	bgHexColor = if bgHexColor.indexOf('#') == 0 then bgHexColor[1..] else bgHexColor
	r = parseInt(bgHexColor.substr(0,2), 16)
	g = parseInt(bgHexColor.substr(2,2), 16)
	b = parseInt(bgHexColor.substr(4,2), 16)
	yiq = ((r*299)+(g*587)+(b*114))/1000
	return if yiq >= 128 then 'black' else 'white'

$ ->
	updateBgColor = (bgColor) ->
		$('body').css('background-color', bgColor)
		fgColor = getForegroundColor(bgColor)
		$('#text').css('color', fgColor)
		
	bgColor = '#990099'
	$('body').css('background-color', bgColor)
	foregroundColor = getForegroundColor(bgColor)
	$('#text').css('color', foregroundColor)
	
	socket = io()
	socket.on('update-background', (bgColor) ->
		updateBgColor(bgColor)
	)