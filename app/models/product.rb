class Product < ActiveRecord::Base
	# before_save :set_long_lat

	reverse_geocoded_by :latitude, :longitude

	mount_uploader :product_picture, ProductPictureUploader

	belongs_to :company

	validates_presence_of [:name, :product_picture]
	validates :order_link, url: { allow_blank: true }

	def price
		unless price_on_request
			if price_in_cent
				price_in_cent / 100.0
			end
		else
			nil
		end
	end

	def price=(amount)
		self.price_in_cent = amount.gsub(',', '.').to_d * 100.0
	end
	
	def price_on_request
		if price_in_cent.nil?
			true
		else
			false
		end
	end

	alias_method :price_on_request?, :price_on_request

	def price_on_request=(value)
		if value == true || value == "1"
			self.price_in_cent = nil
		end
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
