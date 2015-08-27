@buildMap = (maps_hash, set_zoom = false) ->
	handler = Gmaps.build 'Google'
	handler.buildMap
		provider: {}
		internal: 
			id: 'map'
		->
			markers = handler.addMarkers maps_hash
			handler.bounds.extendWith markers
			handler.fitMapToBounds()
			if set_zoom == true
				handler.getMap().setZoom(15)

@autoLocation = () ->
	navigator.geolocation.getCurrentPosition(setPositionByBrowserCoordinates) if navigator.geolocation

setPositionByBrowserCoordinates = (position) ->
	geocoder = new google.maps.Geocoder()

	longitude = position.coords.longitude
	latitude = position.coords.latitude

	latLng = new google.maps.LatLng latitude, longitude

	geocoder.geocode { location: latLng }, (results, status) ->
		address = results[0].formatted_address

		if status == google.maps.GeocoderStatus.OK
			Cookies.set "user_address", address

			$.ajax
				url: gon.api_v1_user_positions_path
				type: 'post'
				data:
					"position":
						"longitude": longitude
						"latitude": latitude
				dataType: 'json'
				headers:
					"Authorization": "Token token=" + sessionToken()
			.done (data, status) ->
				$userAddressSpan.html userAddress()
				$locationField.val userAddress()

				$locationWrapper.fadeIn()