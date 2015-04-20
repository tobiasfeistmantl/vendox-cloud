CarrierWave.configure do |config|
	if Rails.env.test? || Rails.env.development?
		config.storage = :file
		config.enable_processing = false
	else
		config.fog_credentials = {
			# Configuration for Amazon S3
			provider: 'AWS',
			aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
			aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
			region: ENV['AWS_REGION']
		}

		config.fog_directory = ENV['AWS_BUCKET']
	
		config.storage = :fog
	end
end