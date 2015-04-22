module LocationsHelper
	def current_user_location
		session[:user_location]
	end

	def current_user_location_coordinates
		@current_user_location_coordinates ||= Geocoder.coordinates(current_user_location)
	end

	def current_user_location=(new_user_location)
		session[:user_location] = new_user_location
	end

	private

	def hash_for_maps(locations)
		Gmaps4rails.build_markers(locations) do |location, marker|
			marker.lat location.latitude
			marker.lng location.longitude
			marker.infowindow "#{location.name}<br>
								#{location.address}".html_safe
		end
	end
end