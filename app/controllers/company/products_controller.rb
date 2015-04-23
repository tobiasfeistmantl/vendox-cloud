class Company::ProductsController < Company::Base
	include LocationsHelper

	before_action :set_product, only: [:show, :edit, :update, :destroy]
	before_action :check_company_authorization!, except: [:index, :show]

	def index
		if @company == current_company
			@products = @company.products.paginate(page: params[:page])
		else
			@products = @company.products.active.paginate(page: params[:page])
		end
	end

	def new
		@product = @company.products.new
	end

	def create
		@product = @company.products.new product_params

		if @product.save
			flash[:success] = t('messages.created', model: Product.model_name.human)
			redirect_to [@company, @product]
		else
			render :new
		end
	end

	def show
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
		params.require(:product).permit(:name, :price, :status, :product_picture)
	end
end
