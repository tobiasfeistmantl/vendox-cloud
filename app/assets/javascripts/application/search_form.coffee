$ ->
	$locationRenewButton.click ->
		autoLocation()

	$searchConditionField.on 'input', () ->
		$searchButton.prop 'value', gon.i18n_search_for_something

	$searchForm.submit (e) ->
		address = $locationField.val()

		if address != userAddress()
			e.preventDefault()

			geocoder = new google.maps.Geocoder()

			geocoder.geocode { 'address': address }, (results, status) ->
				if status == google.maps.GeocoderStatus.OK
					latitude = results[0].geometry.location.lat()
					longitude = results[0].geometry.location.lng()

					Cookies.set "user_address", results[0].formatted_address

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
						$searchForm.off 'submit'
						$searchForm.submit()
				else if status == google.maps.GeocoderStatus.ZERO_RESULTS
					$locationField.val userAddress()
					$locationFormGroup.addClass 'has-error'
					$errorBlock.slideDown()