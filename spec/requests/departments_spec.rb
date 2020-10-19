require 'rails_helper'
require 'factories/department'

RSpec.describe "api/v1/departments", type: :request do

  let(:valid_attributes) {
    FactoryBot.attributes_for(:administration)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:administration, name: nil)
  }

  let(:valid_headers) {
    headers = sign_up_and_sign_in user_attributes
  }

  describe "GET /index" do
    it "renders a successful response" do
      Department.create! valid_attributes
      get api_v1_departments_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      department = Department.create! valid_attributes
      get api_v1_department_url(department), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Department" do
        expect {
          post api_v1_departments_url,
               params: { department: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Department, :count).by(1)
      end

      it "renders a JSON response with the new department" do
        post api_v1_departments_url,
             params: { department: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Department" do
        expect {
          post api_v1_departments_url,
               params: { department: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Department, :count).by(0)
      end

      it "renders a JSON response with errors for the new department" do
        post api_v1_departments_url,
             params: { department: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        FactoryBot.attributes_for(:development)
      }

      it "updates the requested department" do
        department = Department.create! valid_attributes
        patch api_v1_department_url(department),
              params: { department: new_attributes }, headers: valid_headers, as: :json
        department.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the department" do
        department = Department.create! valid_attributes
        patch api_v1_department_url(department),
              params: { department: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the department" do
        department = Department.create! valid_attributes
        patch api_v1_department_url(department),
              params: { department: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested department" do
      department = Department.create! valid_attributes
      expect {
        delete api_v1_department_url(department), headers: valid_headers, as: :json
      }.to change(Department, :count).by(-1)
    end
  end
end
