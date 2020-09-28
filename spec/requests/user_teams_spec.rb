require 'rails_helper'

RSpec.describe "api/v1/user_teams", type: :request do

  before do
    @headers = sign_up_and_sign_in user_attributes
    
    @user = User.find_by(email: 'fake@gmail.com')
    @user.role = Role.create(name: DEFAULT_ROLES[:employee])
    @user.save!

    @team = Team.create(name: 'Mendoza')
    @team2 = Team.create(name: 'Cordoba')
  end

  let(:valid_attributes) {
    {
      employee_id: @user.id,
      team_id: @team.id
    }
  }

  let(:invalid_attributes) {
    {
      employee_id: @user.id,
      team_id: nil
    } 
  }

  let(:valid_headers) {
    @headers
  }

  describe "GET /index" do
    it "renders a successful response" do
      UserTeam.create! valid_attributes
      get api_v1_user_teams_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user_team = UserTeam.create! valid_attributes
      get api_v1_user_team_url(user_team), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UserTeam" do
        expect {
          post api_v1_user_teams_url,
               params: { user_team: valid_attributes }, headers: valid_headers, as: :json
        }.to change(UserTeam, :count).by(1)
      end

      it "renders a JSON response with the new user_team" do
        post api_v1_user_teams_url,
             params: { user_team: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UserTeam" do
        expect {
          post api_v1_user_teams_url,
               params: { user_team: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(UserTeam, :count).by(0)
      end

      it "renders a JSON response with errors for the new user_team" do
        post api_v1_user_teams_url,
             params: { user_team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          employee_id: @user.id,
          team_id: @team2.id
        }
      }

      it "updates the requested user_team" do
        user_team = UserTeam.create! valid_attributes
        patch api_v1_user_team_url(user_team),
              params: { user_team: new_attributes }, headers: valid_headers, as: :json
        user_team.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the user_team" do
        user_team = UserTeam.create! valid_attributes
        patch api_v1_user_team_url(user_team),
              params: { user_team: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user_team" do
        user_team = UserTeam.create! valid_attributes
        patch api_v1_user_team_url(user_team),
              params: { user_team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user_team" do
      user_team = UserTeam.create! valid_attributes
      expect {
        delete api_v1_user_team_url(user_team), headers: valid_headers, as: :json
      }.to change(UserTeam, :count).by(-1)
    end
  end
end
