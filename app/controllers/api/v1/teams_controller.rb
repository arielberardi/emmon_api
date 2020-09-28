module Api::V1

  class TeamsController < ApplicationController
    before_action :set_team, only: [:show, :update, :destroy]

    # GET /teams
    # GET /teams.json
    def index
      @teams = Team.all
    end

    # GET /teams/1
    # GET /teams/1.json
    def show
    end

    # POST /teams
    # POST /teams.json
    def create
      @team = Team.new(team_params)

      if @team.save
        render :show, status: :created, location: api_v1_team_url(@team)
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /teams/1
    # PATCH/PUT /teams/1.json
    def update
      if @team.update(team_params)
        render :show, status: :ok, location: api_v1_team_url(@team)
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end

    # DELETE /teams/1
    # DELETE /teams/1.json
    def destroy
      @team.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_team
        @team = Team.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def team_params
        params.require(:team).permit(:name)
      end
  end
end
