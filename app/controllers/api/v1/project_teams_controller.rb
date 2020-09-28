module Api::V1
  class ProjectTeamsController < ApplicationController
    include Authentication
    before_action :set_project_team, only: [:show, :update, :destroy]

    # GET /project_teams
    # GET /project_teams.json
    def index
      @project_teams = ProjectTeam.all
    end

    # GET /project_teams/1
    # GET /project_teams/1.json
    def show
    end

    # POST /project_teams
    # POST /project_teams.json
    def create
      @project_team = ProjectTeam.new(project_team_params)

      if @project_team.save
        render :show, status: :created, location: api_v1_project_team_url(@project_team)
      else
        render json: @project_team.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /project_teams/1
    # PATCH/PUT /project_teams/1.json
    def update
      if @project_team.update(project_team_params)
        render :show, status: :ok, location: api_v1_project_team_url(@project_team)
      else
        render json: @project_team.errors, status: :unprocessable_entity
      end
    end

    # DELETE /project_teams/1
    # DELETE /project_teams/1.json
    def destroy
      @project_team.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_project_team
        @project_team = ProjectTeam.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def project_team_params
        params.require(:project_team).permit(:project_id, :team_id)
      end
  end
end