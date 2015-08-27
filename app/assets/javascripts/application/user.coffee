###
Set new user position if session token is available
###

$ ->
	generateTokenIfNotPresent ->
		if ! userAddress()
			$locationWrapper.hide()

			autoLocation()
		else
			$locationField.val userAddress()
			$userAddressSpan.html userAddress()