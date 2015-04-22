module LocationsHelper
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