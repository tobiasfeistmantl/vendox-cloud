json.id company.id
json.name company.name
json.email company.email
json.phone_number company.phone_number
json.street company.street
json.zip_code company.zip_code
json.locality company.locality

if company.respond_to? :distance
	json.distance company.distance.round(2)
end