@buildMap = (maps_hash, set_zoom = false) ->
	handler = Gmaps.build 'Google'
	handler.buildMap { provider: {}, internal: {id: 'map'}}, ->
		markers = handler.addMarkers maps_hash
		handler.bounds.extendWith markers
		handler.fitMapToBounds()
		if set_zoom == true
			handler.getMap().setZoom(15)

@calcRoute = (franchisee_location_lat, franchisee_location_lng, customer_location_lat, customer_location_lng) ->
	origin = new google.maps.LatLng franchisee_location_lat, franchisee_location_lng
	destination = new google.maps.LatLng customer_location_lat, customer_location_lng
	request = {
		origin: origin,
		destination: destination,
		travelMode: google.maps.TravelMode.DRIVING
	}

	directionsService.route request, (response, status) ->
		if status == google.maps.DirectionsStatus.OK
			directionsDisplay.setDirections(response)