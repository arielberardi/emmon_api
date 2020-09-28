module AuthenticationHelper

  def sign_up_and_sign_in params
    
    register_user params
    confirmed_user params
    headers = sign_in params
  end

  def user_attributes
    user = {
      name: 'Fake Name',
      email: 'fake@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    }
  end

  def register_user params
    post user_registration_path, params: params
  end

  def sign_in params

    post user_session_path, params: {
      email: params[:email],
      password: params[:password]
    }

    devise_headers = DeviseTokenAuth.headers_names

    headers = {
      devise_headers[:'access-token'] => response.headers[devise_headers[:'access-token']],
      devise_headers[:'uid'] => response.headers[devise_headers[:'uid']],
      devise_headers[:'client'] => response.headers[devise_headers[:'client']]
    }
  end

  def confirmed_user params

    @user = User.find_by(email: params[:email])
    @user.confirmed_at = Time.now
    @user.save
  end

end