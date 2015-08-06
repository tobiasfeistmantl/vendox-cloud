class ClothingColor < ActiveRecord::Base
	belongs_to :clothing_size
	has_one :product, through: :clothing_size
end
