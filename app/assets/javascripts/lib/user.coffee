@generateTokenIfNotPresent = (callback) ->
	data =
		"session":
			"device": navigator.userAgent

	# Only generate new session token if no one is present	
	if ! sessionToken()
		$.ajax
			url: gon.api_v2_user_sessions_path
			type: 'post'
			data: data
			dataType: 'json'
		.done (data, status) ->
			Cookies.set "session_token", data.token
			callback()
	else
		callback()