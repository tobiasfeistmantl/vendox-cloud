$(function() {
	var $locationFormGroup = $('#form-group-location');
	var $errorBlock = $('#block-error');

	var $searchForm = $('#form-product-search');
	var $searchConditionField = $('#input-search-condition');
	var $locationField = $('#input-location');
	var $locationRenewButton = $('#btn-location-renew');
	var $searchButton = $('#btn-search');

	var $latitudeField = $('#input-latitude');
	var $longitudeField = $('#input-longitude');

	var populatedLocation = $locationField.val();

	$searchConditionField.on('input', function() {
		$searchButton.prop('value', "<%= t('search_for_something') %>");
	})

	$searchForm.submit(function(e) {
		var address = $locationField.val();

		if (address !== populatedLocation) {
			e.preventDefault();

			var geocoder = new google.maps.Geocoder();

			geocoder.geocode({ 'address': address }, function(results, status) {
				if (status === google.maps.GeocoderStatus.OK) {
					$latitudeField.val(results[0].geometry.location.lat());
					$longitudeField.val(results[0].geometry.location.lng());
					$locationField.val(results[0].formatted_address);

					$searchForm.off('submit');
					$searchForm.submit();
				} else if (status === google.maps.GeocoderStatus.ZERO_RESULTS) {
					$locationField.val(populatedLocation);
					$locationFormGroup.addClass('has-error');
					$errorBlock.slideDown();
				}
			});
		} else {
			return true
		}
	});
});
