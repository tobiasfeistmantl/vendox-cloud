class Product < ActiveRecord::Base
	before_save :set_long_lat

	reverse_geocoded_by :latitude, :longitude

	mount_uploader :product_picture, ProductPictureUploader

	belongs_to :company
	belongs_to :category

	validates_presence_of [:name, :price_in_cent, :product_picture]
	validates :price, numericality: true
	validates :order_link, url: { allow_blank: true }

	def price
		if price_in_cent
			price_in_cent / 100.0
		end
	end

	def price=(amount)
		self.price_in_cent = amount.gsub(',', '.').to_d * 100.0
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
