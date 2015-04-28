class Message < ActiveRecord::Base
	belongs_to :company

	validates_presence_of [:content]
end
