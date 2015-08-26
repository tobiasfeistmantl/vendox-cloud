$(function() {
	user_address = "<%= user_address %>";

	var $locationWrapper = $('.wrapper-location');

	if (typeof Cookies.get("session_token") === 'undefined') {
		var path = "/api/v2/users/sessions";

		var data = {
			"session[device]": navigator.userAgent
		}

		$.ajax({
			url: path,
			type: 'post',
			data: data,
			dataType: 'json'
		}).done(function(data, status) {
			Cookies.set("session_token", data["token"])

			session_token = data["token"]

			if (user_address === "") {
				$locationWrapper.hide();

				autoLocation();
			}
		});
	} else {
		session_token = Cookies.get("session_token");

		if (user_address === "") {
			$locationWrapper.hide();

			autoLocation();
		}
	}
});