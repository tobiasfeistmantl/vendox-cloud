class Company::MessagesController < Company::Base
	before_action :check_if_near_company, only: [:create]

	def create
		@message = @company.messages.new message_params

		if @message.save
			flash[:success] = t('messages.created', model: Message.model_name.human)
			redirect_to @company
		else
			flash[:danger] = t('messages.unable_to_save')
			redirect_back and return
		end
	end

	def destroy
	end

	private

	def message_params
		params.require(:message).permit(:content)
	end

	def check_if_near_company
		unless @company.distance_to(current_user_location_coordinates) < 0.5
			flash[:danger] = t('messages.not_in_shop')
			redirect_back and return
		end
	end
end