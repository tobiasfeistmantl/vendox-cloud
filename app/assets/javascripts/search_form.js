$(function() {
	populatedLocation = $('.current-location-field').val();
	$form = $('#product_search');

	$('#q_name_or_description_or_company_name_cont').on('input', function() {
		$('.search-button').prop('value', "<%= t('search_for_something') %>");
	})

	$form.submit(function(e) {
		var address = $('.current-location-field').val();

		if (address !== populatedLocation) {
			e.preventDefault();

			var geocoder = new google.maps.Geocoder();

			geocoder.geocode({ 'address': address }, function(results, status) {
				if (status === google.maps.GeocoderStatus.OK) {
					$('#longitude-field').val(results[0].geometry.location.lng());
					$('#latitude-field').val(results[0].geometry.location.lat());
					$('.current-location-field').val(results[0].formatted_address);

					$form.off('submit');
					$form.submit();
				} else if (status === google.maps.GeocoderStatus.ZERO_RESULTS) {
					$('.current-location-field').val(populatedLocation);
					$('.location-form-group').addClass('has-error');
					$('#helpBlock').slideDown();
				}
			});
		} else {
			return true
		}
	});
});
