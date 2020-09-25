require "rails_helper"

RSpec.describe "Authentication", :type => :request do

  context "User sign up" do

    it "with valid data" do  
      
      post '/auth', params:  {
        name: 'Fake Name',
        email: 'fake@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      }

      expect(response).to have_http_status(:success)
    end

    it "with invalid data" do
      
      post '/auth', params: {
        name: 'Fake Name',
        email: '',
        password: '123456',
        password_confirmation: '123456'
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "with existing user data" do
      
      post '/auth', params:  {
        name: 'Fake Name',
        email: 'fake@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      }

      post '/auth', params:  {
        name: 'Fake Name',
        email: 'fake@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "User sign in" do

    it "with valid data" do

      post '/auth', params: {
        name: 'Fake User',
        email: 'aberardi@rlink.com.ar',
        password: '123456',
        password_confirmation: '123456'
      }

      @user = User.first
      @user.confirmed_at = Time.now
      @user.save

      post '/auth/sign_in', params: {
        email: 'aberardi@rlink.com.ar',
        password: '123456'
      }

      expect(response).to have_http_status(:success)
    end

    it "with invalid data" do

      post '/auth/sign_in', params: {
        email: 'aberardi@rlink.com.ar',
        password: '123456'
      }

      expect(response).to have_http_status(:unauthorized)
    end

    it "retrieve authentication token headers" do

      post '/auth', params: {
        name: 'Fake User',
        email: 'aberardi@rlink.com.ar',
        password: '123456',
        password_confirmation: '123456'
      }

      @user = User.first
      @user.confirmed_at = Time.now
      @user.save

      post '/auth/sign_in', params: {
        email: 'aberardi@rlink.com.ar',
        password: '123456'
      }    

      expect(response.has_header?('access-token')).to eq(true)
    end   

    it "can not access to private routes withouth signed in" do
      
      get home_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "can access to private routes" do
      
      post '/auth', params: {
        name: 'Fake User',
        email: 'aberardi@rlink.com.ar',
        password: '123456',
        password_confirmation: '123456'
      }

      @user = User.first
      @user.confirmed_at = Time.now
      @user.save

      post '/auth/sign_in', params: {
        email: 'aberardi@rlink.com.ar',
        password: '123456'
      }    

      devise_headers = DeviseTokenAuth.headers_names

      headers = {
        devise_headers[:'access-token'] => response.headers[devise_headers[:'access-token']],
        devise_headers[:'uid'] => response.headers[devise_headers[:'uid']],
        devise_headers[:'client'] => response.headers[devise_headers[:'client']]
      }

      get home_path, params: {}, headers: headers
      expect(response).to have_http_status(:success)
    end

  end

  context "User sign out" do

    it "after sign in" do

      post '/auth', params: {
        name: 'Fake User',
        email: 'aberardi@rlink.com.ar',
        password: '123456',
        password_confirmation: '123456'
      }

      @user = User.first
      @user.confirmed_at = Time.now
      @user.save

      post '/auth/sign_in', params: {
        email: 'aberardi@rlink.com.ar',
        password: '123456'
      }    

      devise_headers = DeviseTokenAuth.headers_names

      headers = {
        devise_headers[:'access-token'] => response.headers[devise_headers[:'access-token']],
        devise_headers[:'uid'] => response.headers[devise_headers[:'uid']],
        devise_headers[:'client'] => response.headers[devise_headers[:'client']]
      }

      delete destroy_user_session_path, params: {}, headers: headers
      expect(response).to have_http_status(:success)
    end

    it "before sign in" do

      delete destroy_user_session_path, params: {}
      expect(response).to have_http_status(:not_found)
    end

  end

end