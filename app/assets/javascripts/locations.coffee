@buildMap = (maps_hash, set_zoom = false) ->
	handler = Gmaps.build 'Google'
	handler.buildMap { provider: {}, internal: {id: 'map'}}, ->
		markers = handler.addMarkers maps_hash
		handler.bounds.extendWith markers
		handler.fitMapToBounds()
		if set_zoom == true
			handler.getMap().setZoom(15)
