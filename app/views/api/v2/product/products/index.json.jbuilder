json.array! @products do |product|
	json.partial! "api/v2/company/products/attributes", product: product

	json.company do
		json.partial! "api/v2/company/companies/attributes", company: product.company
	end
	
	if product.clothes
		json.clothing_sizes do
			json.array! product.clothing_sizes do |clothing_size|
				json.title clothing_size.title
			end
		end
	end
end