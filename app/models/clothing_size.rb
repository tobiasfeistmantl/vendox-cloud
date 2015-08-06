class ClothingSize < ActiveRecord::Base
	belongs_to :product

	has_many :size_color_combinations
	has_many :colors, through: :size_color_combinations, source: :clothing_color
end
