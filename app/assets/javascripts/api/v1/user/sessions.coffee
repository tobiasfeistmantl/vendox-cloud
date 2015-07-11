# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@newSession = () ->
	path = "/api/v1/users/sessions"

	data = {
		"device": navigator.userAgent
	}

	$.ajax
		url: path,
		type: 'post',
		data: data,
		dataType: 'json',
	.done (data, status) ->
		session_token = data["token"]