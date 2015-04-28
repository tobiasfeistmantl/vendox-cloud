class Company < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable, :registerable
	devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

	validates_presence_of [:name, :email, :street, :zip_code, :locality]

	validates :slug, uniqueness: true

	extend FriendlyId
	friendly_id :name, use: :slugged

	geocoded_by :address
	after_validation :geocode

	has_many :products
	has_many :messages

	def address
		[street, zip_code, locality].compact.join(', ')
	end

	def product_publishing_remaining?
		if remaining_products.nil? || remaining_products > 0
			true
		else
			false
		end
	end

	def decrease_product_counter(nr = 1)
		if not remaining_products.nil?
			if remaining_products >= nr
				self.remaining_products -= nr
			else
				false
			end
		else
			nil
		end
	end
end
