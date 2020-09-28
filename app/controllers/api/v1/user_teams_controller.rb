module Api::V1
  class UserTeamsController < ApplicationController
    include Authentication
    before_action :set_user_team, only: [:show, :update, :destroy]

    # GET /user_teams
    # GET /user_teams.json
    def index
      @user_teams = UserTeam.all
    end

    # GET /user_teams/1
    # GET /user_teams/1.json
    def show
    end

    # POST /user_teams
    # POST /user_teams.json
    def create
      @user_team = UserTeam.new(user_team_params)

      if @user_team.save
        render :show, status: :created, location: api_v1_user_team_url(@user_team)
      else
        render json: @user_team.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /user_teams/1
    # PATCH/PUT /user_teams/1.json
    def update
      if @user_team.update(user_team_params)
        render :show, status: :ok, location: api_v1_user_team_url(@user_team)
      else
        render json: @user_team.errors, status: :unprocessable_entity
      end
    end

    # DELETE /user_teams/1
    # DELETE /user_teams/1.json
    def destroy
      @user_team.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user_team
        @user_team = UserTeam.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_team_params
        params.require(:user_team).permit(:employee_id, :team_id)
      end
  end
end
