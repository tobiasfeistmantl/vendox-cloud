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

	def address
		[street, zip_code, locality].compact.join(', ')
	end
end
