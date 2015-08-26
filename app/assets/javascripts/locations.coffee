@buildMap = (maps_hash, set_zoom = false) ->
	handler = Gmaps.build 'Google'
	handler.buildMap { provider: {}, internal: {id: 'map'}}, ->
		markers = handler.addMarkers maps_hash
		handler.bounds.extendWith markers
		handler.fitMapToBounds()
		if set_zoom == true
			handler.getMap().setZoom(15)

@autoLocation = () ->
	navigator.geolocation.getCurrentPosition(setPosition) if navigator.geolocation

setPosition = (position) ->
	geocoder = new google.maps.Geocoder()

	longitude = position.coords.longitude
	latitude = position.coords.latitude

	latLng = new google.maps.LatLng latitude, longitude

	$locationField = $('#input-location')

	geocoder.geocode { location: latLng }, (results, status) ->
		address = results[0].formatted_address

		path = "/api/v1/users/positions"

		data = {
			"position": {
				"longitude": longitude,
				"latitude": latitude,
				"address": address
			}
		}

		if status == google.maps.GeocoderStatus.OK
			user_address = address

			$.ajax
				url: path,
				type: 'post',
				data: data,
				dataType: 'json',
				headers: {
					"Authorization": "Token token=" + session_token
				},
			.done (data, status) ->
				$('#user-address').html user_address
				$('.current-location-wrapper').fadeIn()

				if $locationField.length
					$locationField.val(address)