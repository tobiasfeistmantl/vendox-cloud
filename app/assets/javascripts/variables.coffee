$ ->
	$.extend window,
		$searchForm: $('#form-product-search')

		$locationFormGroup: $('#form-group-location')
		$errorBlock: $('#block-error')

		$searchConditionField: $('#input-search-condition')
		$locationField: $('#input-location')
		$latitudeField: $('#input-latitude')
		$longitudeField: $('#input-longitude')

		$locationRenewButton: $('#btn-location-renew')
		$searchButton: $('#btn-search')

		$locationRenewLink: $('.lnk-location-renew')

		$locationWrapper: $('.wrapper-location')

		$userAddressSpan: $('#span-user-address')

		sessionToken: () ->
			Cookies.get "session_token"

		userAddress: () ->
			Cookies.get "user_address"