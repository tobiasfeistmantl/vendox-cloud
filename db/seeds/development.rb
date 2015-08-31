20.times do |i|
	c = Company.new(
		name: "Company #{i}",
		email: "c#{i}@vendox.test",
		password: "123admin#{i}",
		street: "Fiecht-Au 31",
		zip_code: "6134",
		locality: "Vomp",
		latitude: 47.358433,
		longitude: 11.703453,
		phone_number: "05242#{i}90820",
		vat_number: "ATU0123456789#{i}"
	)

	c.save!(validate: false)

	10.times do |pi|
		p = c.products.new(
			name: "Product #{pi}",
			price: "#{pi}",
			status: :active,
			description: "Blabla #{pi}"
		)

		p.product_picture = File.open("/Users/tobiasfeistmantl/Developer/Web/test/test-image.jpeg")

		if pi == 11
			p.status = 1
		end

		p.save!
	end
end