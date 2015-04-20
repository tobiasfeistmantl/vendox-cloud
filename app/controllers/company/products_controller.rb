class Company::ProductsController < Company::Base
	before_action :set_product, only: [:show, :edit, :update, :destroy]
	before_action :check_company_authorization!, except: [:index, :show]

	def index
		@products = @company.products
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
		@product = @company.products.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:danger] = t('messages.not_found', model: Product.model_name.human)
		redirect_back and return
	end

	def product_params
		params.require(:product).permit(:name, :price_in_cent, :status, :product_picture)
	end
end
