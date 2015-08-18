class Company < ActiveRecord::Base
	include ActiveModel::Validations

	has_secure_password

	validates_presence_of [:name, :email, :password, :street, :zip_code, :locality, :vat_number, :longitude, :latitude, :phone_number]
	validates_uniqueness_of [:name, :email, :phone_number, :slug, :vat_number]
	
	validates :vat_number, valvat: { lookup: true }

	extend FriendlyId
	friendly_id :name, use: :slugged

	geocoded_by :address
	before_validation :geocode, if: ->(obj){ obj.address.present? and obj.street_changed? }

	has_many :products

	def address
		if street.present? && zip_code.present? && locality.present?
			[street, zip_code, locality].compact.join(', ')
		end
	end

	def product_publishing_remaining?
		if remaining_products.nil? || remaining_products > 0
			true
		else
			false
		end
	end

	def decrement_product_counter(nr = 1)
		if not remaining_products.nil?
			if remaining_products >= nr
				update(remaining_products: (remaining_products - nr))
			else
				false
			end
		end
	end

	def coordinates
		[latitude, longitude]
	end



	def confirmed?
		confirmation_token.blank?
	end

	def confirm
		update_attribute(:confirmation_token, nil)
	end

	def generate_confirmation_token
		self.confirmation_token = SecureRandom.urlsafe_base64
	end
end
