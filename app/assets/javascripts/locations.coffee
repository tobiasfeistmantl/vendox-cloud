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

	geocoder.geocode { location: latLng }, (results, status) ->
		address = results[0].formatted_address

		path = "/position?lng=" + longitude + "&lat=" + latitude + "&addr=" + address + "&a=true"

		if status == google.maps.GeocoderStatus.OK
			$.get path, (data, status) ->
				$('.current-location-info').html data

				if $('.current-location-field').length
					$('.current-location-field').val(address)