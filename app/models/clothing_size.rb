class ClothingSize < ActiveRecord::Base
	belongs_to :product
	has_many :colors, class_name: "ClothingColor"
end
