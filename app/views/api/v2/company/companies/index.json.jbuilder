json.array!(@companies) do |company|
	json.partial! "attributes", company: company
end