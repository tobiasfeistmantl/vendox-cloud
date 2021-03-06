json.array! @products do |product|
	json.partial! "api/v2/company/products/attributes", product: product

	json.company do
		json.partial! "api/v2/company/companies/attributes", company: product.company
	end
end