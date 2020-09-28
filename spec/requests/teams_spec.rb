require 'rails_helper'

RSpec.describe Api::V1::TeamsController, type: :request do

  let(:valid_attributes) {
    { name: 'Mendoza' }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  let(:valid_headers) {
    headers = sign_up_and_sign_in user_attributes
  }

  describe "GET /index" do
    it "renders a successful response" do
      Team.create! valid_attributes
      get api_v1_teams_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      team = Team.create! valid_attributes
      get api_v1_team_url(team), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Team" do
        expect {
          post api_v1_teams_url,
               params: { team: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Team, :count).by(1)
      end

      it "renders a JSON response with the new team" do
        post api_v1_teams_url,
             params: { team: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Team" do
        expect {
          post api_v1_teams_url,
               params: { team: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Team, :count).by(0)
      end

      it "renders a JSON response with errors for the new team" do
        post api_v1_teams_url,
             params: { team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Buenos Aires' }
      }

      it "updates the requested team" do
        team = Team.create! valid_attributes
        patch api_v1_team_url(team),
              params: { team: new_attributes }, headers: valid_headers, as: :json
        team.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the team" do
        team = Team.create! valid_attributes
        patch api_v1_team_url(team),
              params: { team: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the team" do
        team = Team.create! valid_attributes
        patch api_v1_team_url(team),
              params: { team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested team" do
      team = Team.create! valid_attributes
      expect {
        delete api_v1_team_url(team), headers: valid_headers, as: :json
      }.to change(Team, :count).by(-1)
    end
  end
end
