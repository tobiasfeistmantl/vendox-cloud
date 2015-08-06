class ClothingColor < ActiveRecord::Base
	has_many :size_color_combinations
	has_many :sizes, through: :size_color_combinations, source: :clothing_size

	has_one :product, through: :clothing_size
end
