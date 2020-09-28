require 'rails_helper'

RSpec.describe "api/v1/project_teams", type: :request do

  before do
    @headers = sign_up_and_sign_in user_attributes

    project_manager = User.create(
      name: 'Fake PM',
      email: 'fakepm@pm.com',
      password: '123456', 
      password_confirmation: '123456',
      role: Role.create(name: DEFAULT_ROLES[:project_manager])
    )

    client = User.create(
      name: 'Fake Client',
      email: 'fakecl@cl.com',
      password: '123456', 
      password_confirmation: '123456',
      role: Role.create(name: DEFAULT_ROLES[:client])
    )

    @project = Project.create( 
      name: 'Fake project', 
      description: '',
      start_date: Time.now, 
      end_date: 5.days.from_now, 
      project_manager: project_manager, 
      client: client,
    )

    @team = Team.create(name: 'Mendoza')
    @team2 = Team.create(name: 'Cordoba')
  end

  let(:valid_attributes) {
    {
      project_id: @project.id,
      team_id: @team.id
    }
  }

  let(:invalid_attributes) {
    {
      employee_id: @project.id,
      team_id: nil
    } 
  }

  let(:valid_headers) {
    @headers
  }

  describe "GET /index" do
    it "renders a successful response" do
      ProjectTeam.create! valid_attributes
      get api_v1_project_teams_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      project_team = ProjectTeam.create! valid_attributes
      get api_v1_project_team_url(project_team), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ProjectTeam" do
        expect {
          post api_v1_project_teams_url,
               params: { project_team: valid_attributes }, headers: valid_headers, as: :json
        }.to change(ProjectTeam, :count).by(1)
      end

      it "renders a JSON response with the new project_team" do
        post api_v1_project_teams_url,
             params: { project_team: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ProjectTeam" do
        expect {
          post api_v1_project_teams_url,
               params: { project_team: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(ProjectTeam, :count).by(0)
      end

      it "renders a JSON response with errors for the new project_team" do
        post api_v1_project_teams_url,
             params: { project_team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          employee_id: @project.id,
          team_id: @team2.id
        }
      }

      it "updates the requested project_team" do
        project_team = ProjectTeam.create! valid_attributes
        patch api_v1_project_team_url(project_team),
              params: { project_team: new_attributes }, headers: valid_headers, as: :json
        project_team.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the project_team" do
        project_team = ProjectTeam.create! valid_attributes
        patch api_v1_project_team_url(project_team),
              params: { project_team: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the project_team" do
        project_team = ProjectTeam.create! valid_attributes
        patch api_v1_project_team_url(project_team),
              params: { project_team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested project_team" do
      project_team = ProjectTeam.create! valid_attributes
      expect {
        delete api_v1_project_team_url(project_team), headers: valid_headers, as: :json
      }.to change(ProjectTeam, :count).by(-1)
    end
  end
end
