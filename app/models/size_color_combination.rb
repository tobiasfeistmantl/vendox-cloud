class SizeColorCombination < ActiveRecord::Base
	belongs_to :clothing_size
	belongs_to :clothing_color
end
