module DeviseTokenAuth
  class ConfirmationsController < DeviseTokenAuth::ApplicationController
    def show
      @resource = resource_class.confirm_by_token(params[:confirmation_token])

      if @resource.errors.empty?
        render json: { 'status': 'success' }, status: :ok
      else
        render json: { 'status': 'error', 'errors': @resource.errors }, status: :unauthorized
      end
    end
  end
end