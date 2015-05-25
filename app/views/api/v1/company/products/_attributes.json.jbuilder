json.extract! product, :id, :name, :price, :description, :longitude, :latitude

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

json.category do
	if product.category.present?
		json.id product.category.id
		json.name product.category.name
	else
		json.id nil
		json.name nil
	end
end

if product.respond_to? :distance
	json.distance product.distance.round(2)
end