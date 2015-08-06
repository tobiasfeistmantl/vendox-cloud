json.array! @products do |product|
	json.partial! "attributes", product: product
end