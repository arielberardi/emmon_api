require 'rails_helper'
require 'factories/role'  

RSpec.describe "api/v1/roles", type: :request do

  let(:valid_attributes) {
    FactoryBot.attributes_for(:role_admin)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:role_admin, name: nil)
  }

  let(:valid_headers) {
    headers = sign_up_and_sign_in user_attributes
  }

  describe "GET /index" do
    it "renders a successful response" do
      Role.create! valid_attributes
      get api_v1_roles_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      role = Role.create! valid_attributes
      get api_v1_role_url(role), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Role" do
        expect {
          post api_v1_roles_url,
               params: { role: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Role, :count).by(1)
      end

      it "renders a JSON response with the new role" do
        post api_v1_roles_url,
             params: { role: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Role" do
        expect {
          post api_v1_roles_url,
               params: { role: invalid_attributes }, as: :json
        }.to change(Role, :count).by(0)
      end

      it "renders a JSON response with errors for the new role" do
        post api_v1_roles_url,
             params: { role: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        FactoryBot.attributes_for(:role_employee)
      }

      it "updates the requested role" do
        role = Role.create! valid_attributes
        patch api_v1_role_url(role),
              params: { role: new_attributes }, headers: valid_headers, as: :json
        role.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the role" do
        role = Role.create! valid_attributes
        patch api_v1_role_url(role),
              params: { role: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the role" do
        role = Role.create! valid_attributes
        patch api_v1_role_url(role),
              params: { role: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested role" do
      role = Role.create! valid_attributes
      expect {
        delete api_v1_role_url(role), headers: valid_headers, as: :json
      }.to change(Role, :count).by(-1)
    end
  end
end
