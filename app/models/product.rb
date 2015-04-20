class Product < ActiveRecord::Base
	before_save :set_long_lat

	reverse_geocoded_by :latitude, :longitude

	mount_uploader :product_picture, ProductPictureUploader

	belongs_to :company

	validates_presence_of [:name, :price_in_cent, :product_picture]
	validates :price, numericality: true

	def price
		if price_in_cent
			price_in_cent / 100
		end
	end

	def price=(amount)
		self.price_in_cent = amount.to_i * 100
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
