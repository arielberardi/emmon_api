module Api::V1
  class UserHistoricalsController < ApplicationController
    include Authentication
    before_action :set_user_historical, only: [:show, :update, :destroy]

    # GET /user_historicals
    # GET /user_historicals.json
    def index
      @user_historicals = UserHistorical.all
    end

    # GET /user_historicals/1
    # GET /user_historicals/1.json
    def show
    end

    # POST /user_historicals
    # POST /user_historicals.json
    def create
      @user_historical = UserHistorical.new(user_historical_params)

      if @user_historical.save
        render :show, status: :created, location: api_v1_user_historical_url(@user_historical)
      else
        render json: @user_historical.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /user_historicals/1
    # PATCH/PUT /user_historicals/1.json
    def update
      if @user_historical.update(user_historical_params)
        render :show, status: :ok, location: api_v1_user_historical_url(@user_historical)
      else
        render json: @user_historical.errors, status: :unprocessable_entity
      end
    end

    # DELETE /user_historicals/1
    # DELETE /user_historicals/1.json
    def destroy
      @user_historical.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user_historical
        @user_historical = UserHistorical.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_historical_params
        params.require(:user_historical).permit(:start_date, :end_date, :description, :user_id)
      end
  end
end