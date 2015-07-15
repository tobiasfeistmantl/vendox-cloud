json.extract! product, :id, :name, :price, :longitude, :latitude

if product.description.present?
	json.description product.description
else
	json.description nil
end

if product.order_link.present?
	json.order_link product.order_link
else
	json.order_link nil
end

json.picture do
	json.url product.product_picture.url

	json.thumb do
		json.url product.product_picture.thumb.url
	end
end

if product.respond_to? :distance
	json.distance product.distance.round(2)
end

json.url company_product_url(company_id: product.company.id, id: product.id)