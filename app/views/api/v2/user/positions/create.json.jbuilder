json.extract! @position, :id, :longitude, :latitude, :user_session_id

if user_address.present?
	json.address user_address
end