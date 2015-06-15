class UserPosition < ActiveRecord::Base
	belongs_to :user_session

	validates_presence_of [:latitude, :longitude]
end