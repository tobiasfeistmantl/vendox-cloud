module CountHelper
	def count_user(product)
		unless session[:visited_products].kind_of?(Array)
			session[:visited_products] = []
		end

		if not current_company == product.company
			if not session[:visited_products].include?(product.id)
				session[:visited_products].append(product.id)

				puts product.count
				product.count += 1
				puts product.count
				product.save
			end
		end
	end
end