require "rails_helper"
require "./spec/support/authentication_helper"

RSpec.configure do |c|
  c.include AuthenticationHelper
end


RSpec.describe "Authentication" , :type => :request do

  before do
    @params = create_user
  end

  context "User sign up" do

    it "with valid data" do  

      register_user @params
      expect(response).to have_http_status(:success)
    end

    it "with invalid data" do      
      @params[:email] = ''

      register_user @params
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "with existing user data" do
      
      register_user @params
      register_user @params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "User sign in" do

    it "with valid data" do

      headers = sign_up_and_sign_in @params
      expect(response).to have_http_status(:success)
    end

    it "with invalid data" do

      sign_in @params
      expect(response).to have_http_status(:unauthorized)
    end

    it "retrieve authentication token headers" do

      headers = sign_up_and_sign_in @params
      expect(response.has_header?('access-token')).to eq(true)
    end   

    it "can not access to private routes withouth signed in" do
      
      get home_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "can access to private routes" do
      
      headers = sign_up_and_sign_in @params

      get home_path, params: {}, headers: headers
      expect(response).to have_http_status(:success)
    end

  end

  context "User sign out" do

    it "after sign in" do

      headers = sign_up_and_sign_in @params

      delete destroy_user_session_path, params: {}, headers: headers
      expect(response).to have_http_status(:success)
    end

    it "before sign in" do

      delete destroy_user_session_path, params: {}
      expect(response).to have_http_status(:not_found)
    end

  end

end