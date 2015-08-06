json.extract! product, :id, :name, :price_in_cent, :longitude, :latitude

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

json.clothes product.clothes

json.url company_product_url(company_id: product.company.id, id: product.id)
	
if product.clothes
	json.clothing_sizes do
		json.array! product.clothing_sizes do |clothing_size|
			json.extract! clothing_size, :title, :description

			json.colors do
				json.array! clothing_size.colors do |color|
					json.extract! color, :color, :hex_code, :price_in_cent
				end
			end
		end
	end
end