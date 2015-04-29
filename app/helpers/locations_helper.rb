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

	def set_current_user_location(address, lat, lng)
		session[:user_location] = address
		session[:user_lat] = lat
		session[:user_lng] = lng

		session[:last_location_update] = Time.now

		session[:user_location]
	end

	def current_user_location_expired?
		if session[:last_location_update]
			if session[:last_location_update].to_time < Time.now - 20.minutes
				true
			else
				false
			end
		else
			false
		end
	end

	def auto_located?
		if session[:auto_located]
			true
		else
			false
		end
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