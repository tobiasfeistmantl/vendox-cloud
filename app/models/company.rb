class Company < ActiveRecord::Base
	include ActiveModel::Validations

	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :registerable

	validates_presence_of [:name, :email, :street, :zip_code, :locality, :vat_number, :longitude, :latitude, :phone_number]
	validates_uniqueness_of [:name, :email, :phone_number, :slug, :vat_number]
	validates_with CountryValidator

	validates :vat_number, valvat: { lookup: true }

	extend FriendlyId
	friendly_id :name, use: :slugged

	geocoded_by :address
	before_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

	before_validation :normalize_vat_number

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

	protected

	def normalize_vat_number
		self.vat_number = Valvat::Utils.normalize(vat_number)
	end

	def check_if_from_austria
		if not Valvat::Utils.split(vat_number)[0] == "AT"
			errors.add(:vat_number, "not from austria")
		end
	end
end
