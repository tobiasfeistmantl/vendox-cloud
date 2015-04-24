module LocationsHelper
	def current_user_location
		if company_signed_in?
			current_company.address
		else
			session[:user_location]
		end
	end

	def current_user_location_coordinates
		if company_signed_in?
			[current_company.latitude, current_company.longitude]
		else
			@current_user_location_coordinates ||= [session[:user_lat], session[:user_lng]]
		end
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