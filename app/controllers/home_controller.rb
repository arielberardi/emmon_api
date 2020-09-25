# This is only for test purpose
class HomeController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index 
    render json: { 'status': 'sucess' }
  end
end
