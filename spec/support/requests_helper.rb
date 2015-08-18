module RequestsHelper
	def request_with_session(method, path, sid, token, params={}, headers={})
		params.merge!(sid: sid)
		headers.merge!("Authorization" => "Token token=#{token}")
		
		send method, path, params, headers
	end
end