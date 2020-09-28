require 'rails_helper'

RSpec.describe "api/v1/projects", type: :request do

  before do
    role_pm = Role.create(name: DEFAULT_ROLES[:project_manager])
    role_client = Role.create(name: DEFAULT_ROLES[:client])

    @project_manager = User.create(name: 'Fake PM',
        email: 'pm@gmail.com',
        password: '123456', 
        password_confirmation: '123456',
        role: role_pm
      )

    @client = User.create(name: 'Fake Client',
        email: 'fc@gmail.com',
        password: '123456', 
        password_confirmation: '123456',
        role: role_client
      )
  end

  let(:valid_attributes) {
    { 
      name: 'Test project',
      description: '',
      start_date: 1.day.ago,
      end_date: 2.day.from_now,
      project_manager_id: @project_manager.id,
      client_id: @client.id
    }
  }

  let(:invalid_attributes) {
    { 
      name: nil,
      description: '',
      start_date: 1.day.ago,
      end_date: 2.day.from_now,
      project_manager_id: @project_manager.id,
      client_id: @client.id
    }
  }

  let(:valid_headers) {
    headers = sign_up_and_sign_in user_attributes
  }

  describe "GET /index" do
    it "renders a successful response" do
      Project.create! valid_attributes
      get api_v1_projects_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      project = Project.create! valid_attributes
      get api_v1_project_url(project), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Project" do
        expect {
          post api_v1_projects_url,
               params: { project: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Project, :count).by(1)
      end

      it "renders a JSON response with the new project" do
        post api_v1_projects_url,
             params: { project: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project" do
        expect {
          post api_v1_projects_url,
               params: { project: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Project, :count).by(0)
      end

      it "renders a JSON response with errors for the new project" do
        post api_v1_projects_url,
             params: { project: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { 
          name: 'Test project',
          description: '',
          start_date: 1.day.ago,
          end_date: 5.day.from_now,
          project_manager_id: @project_manager.id,
          client_id: @client.id
        }
      }

      it "updates the requested project" do
        project = Project.create! valid_attributes
        patch api_v1_project_url(project),
              params: { project: new_attributes }, headers: valid_headers, as: :json
        project.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the project" do
        project = Project.create! valid_attributes
        patch api_v1_project_url(project),
              params: { project: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the project" do
        project = Project.create! valid_attributes
        patch api_v1_project_url(project),
              params: { project: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete api_v1_project_url(project), headers: valid_headers, as: :json
      }.to change(Project, :count).by(-1)
    end
  end
end
