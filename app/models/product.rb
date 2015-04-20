class Product < ActiveRecord::Base
	before_save :set_long_lat

	reverse_geocoded_by :latitude, :longitude

	belongs_to :company

	def price
		price_in_cent / 100.00
	end

	STATUSES = [:active, :inactive]
	enum status: STATUSES

	private

	def set_long_lat
		unless self.longitude || self.latitude
			self.longitude = company.longitude
			self.latitude = company.latitude
		end
	end
end
