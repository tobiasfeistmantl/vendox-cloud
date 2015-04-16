class Product < ActiveRecord::Base
	belongs_to :company

	def price
		price_in_cent / 100.00
	end

	STATUSES = [:active, :inactive]
	enum status: STATUSES
end
