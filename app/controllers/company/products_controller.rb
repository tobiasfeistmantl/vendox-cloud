class Company::ProductsController < Company::Base
	include LocationsHelper
	include CountHelper

	before_action :set_product, only: [:show, :edit, :update, :destroy]
	before_action :check_company_authorization!, except: [:index, :show]
	before_action :check_if_product_limit_archived, only: [:new, :create]

	def index
		if @company == current_company
			@products = @company.products.paginate(page: params[:page])
		else
			@products = @company.products.active.paginate(page: params[:page])
		end
	end

	def new
		unless @company.remaining_products.nil?
			if @company.remaining_products <= 2
				flash[:warning] = t('messages.only_x_products_anymore', count: @company.remaining_products)
			end
		end

		@product = @company.products.new
	end

	def create
		@product = @company.products.new product_params

		if @product.save
			@company.decrease_product_counter
			@company.save

			flash[:success] = t('messages.created', model: Product.model_name.human)
			redirect_to [@company, @product]
		else
			render :new
		end
	end

	def show
		count_user(@product)

		@maps_hash = hash_for_maps(@product.company)
	end

	def edit
	end

	def update
		if @product.update(product_params)
			flash[:success] = t('messages.updated', model: Product.model_name.human)
			redirect_to [@company, @product]
		else
			render :edit
		end
	end

	def destroy
	end

	private

	def set_product
		if @company == current_company
			@product = @company.products.find(params[:id])
		else
			@product = @company.products.active.find(params[:id])
		end
	rescue ActiveRecord::RecordNotFound
		flash[:danger] = t('messages.not_found', model: Product.model_name.human)
		redirect_back and return
	end

	def product_params
		params.require(:product).permit(:name, :price, :status, :description, :category_id, :order_link, :product_picture)
	end

	def check_if_product_limit_archived
		unless @company.product_publishing_remaining?
			flash[:danger] = t('messages.product_limit_archived')
			redirect_back and return
		end
	end
end
