class Company < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

	validates_presence_of [:name, :email, :password, :street, :zip_code, :locality]

	geocoded_by :address
	after_validation :geocode

	has_many :products

	def address
		[street, zip_code, locality].compact.join(', ')
	end
end
