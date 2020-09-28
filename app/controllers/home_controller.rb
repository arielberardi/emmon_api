# This is only for test purpose
class HomeController < ApplicationController
  include Authentication
  include Authorization
  respond_to :json

  def index 
    render json: { 'status': 'sucess' }
  end
end
