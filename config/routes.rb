Rails.application.routes.draw do
	root 'welcome#index'

	scope "(:locale)", locale: /en|de/ do
		get 'position' => 'application#set_user_position'
		get 'imprint' => 'welcome#imprint'
		get 'about' => 'welcome#about'

		resources :products, module: :product, only: [:index]

		resources :feedbacks, only: [:new, :create]
		
		resources :companies, only: [:new, :create, :show], module: :company do
			resources :products
			get "confirm/:confirmation_token" => "companies#confirm", as: :confirm
			resources :password, only: [:update, :edit], controller: :password_reset, param: :reset_token
		end

		namespace :company, path: :companies do
			resources :sessions, only: [:new, :create]
			delete "sessions" => "sessions#destroy"
			resources :password, only: [:new], controller: :password_reset
			post 'password' => "password_reset#create", as: :password_reset_create
		end

		get ':id' => 'company/companies#show'
	end

	namespace 'api', defaults: { format: :json } do
		namespace 'v1' do
			resources :companies, module: :company, only: [:index, :show] do 
				resources :products, only: [:index, :show]
			end

			resources :products, module: :product, only: [:index]

			namespace :user, path: :users do
				resources :sessions, only: [:create]
				get 'session' => "sessions#show"
				resources :positions, only: [:index, :create, :show]
			end
		end

		namespace 'v2' do
			resources :companies, module: :company, only: [:index, :show] do 
				resources :products, only: [:index, :show]
			end

			resources :products, module: :product, only: [:index]

			namespace :user, path: :users do
				resources :sessions, only: [:create]
				get 'session' => "sessions#show"
				resources :positions, only: [:index, :create, :show]
			end
		end
	end

	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end
