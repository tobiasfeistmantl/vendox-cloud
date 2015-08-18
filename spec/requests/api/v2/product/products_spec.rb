require 'rails_helper'

RSpec.describe "Products API V2", type: :request do
	describe "get products" do
		it "failed because of missing credentials" do
			get api_v2_products_path
			
			json_response_body = JSON.parse(response.body)

			expect(response).to have_http_status(404)
			expect(json_response_body["error"]["type"]).to eq("USER_SESSION_NOT_FOUND")
		end

		it "failed because of missing session token" do
			user_session = FactoryGirl.create :user_session

			get api_v2_products_path, sid: user_session.id

			json_response_body = JSON.parse(response.body)

			expect(response).to have_http_status(401)
			expect(json_response_body["error"]["type"]).to eq("SESSION_TOKEN_NOT_PROVIDED")
		end

		it "failed because of invalid session token" do
			user_session = FactoryGirl.create :user_session

			request_with_session :get, api_v2_products_path, user_session.id, "InvalidToken123"

			json_response_body = JSON.parse(response.body)

			expect(response).to have_http_status(401)
			expect(json_response_body["error"]["type"]).to eq("INVALID_USER_SESSION_TOKEN_COMBINATION")
		end

		it "works because of valid session id and token and does not have a distance" do
			user_session = FactoryGirl.create :user_session

			company = FactoryGirl.create :company

			request_with_session :get, api_v2_products_path, user_session.id, user_session.token

			json_response_body = JSON.parse(response.body)
			puts(json_response_body)

			expect(response).to have_http_status(200)
		end
	end
end
