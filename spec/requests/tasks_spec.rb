require 'rails_helper'

RSpec.describe "api/v1/tasks", type: :request do

  before do
    role_client = Role.create(name: DEFAULT_ROLES[:client])
    role_emp = Role.create(name: DEFAULT_ROLES[:employee])
    role_pm = Role.create(name: DEFAULT_ROLES[:project_manager])

    @user = User.create(
      name: 'Fake User', 
      email: 'fake@gg.com', 
      password: '123456', 
      password_confirmation: '123456',
      role: role_emp
    )

    user_pm = User.create(
      name: 'Fake PM', 
      email: 'fakepm@gg.com', 
      password: '123456', 
      password_confirmation: '123456',
      role: role_pm
    )

    user_client = User.create(
      name: 'Fake Client', 
      email: 'fakecl@gg.com', 
      password: '123456', 
      password_confirmation: '123456',
      role: role_client
    )

    @project = Project.create(
      name: 'Fake Project',
      description: '',
      start_date: Time.now,
      end_date: 2.day.from_now,
      project_manager: user_pm,
      client: user_client
    )

  end

  let(:valid_attributes) {
    { 
      name: 'Test task',
      description: '',
      start_date: 1.day.ago,
      end_date: 2.day.from_now,
      priority: DEFAULT_PRIORITIES[:normal],
      current_hours: 0,
      project_id: @project.id,
      user_id: @user.id
    }
  }

  let(:invalid_attributes) {
    { 
      name: nil,
      description: '',
      start_date: 1.day.ago,
      end_date: 2.day.from_now,
      priority: DEFAULT_PRIORITIES[:normal],
      current_hours: 0,
      project_id: @project.id,
      user_id: @user.id
    }
  }

  let(:valid_headers) {
    headers = sign_up_and_sign_in user_attributes
  }

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get api_v1_tasks_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create! valid_attributes
      get api_v1_task_url(task), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post api_v1_tasks_url,
               params: { task: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Task, :count).by(1)
      end

      it "renders a JSON response with the new task" do
        post api_v1_tasks_url,
             params: { task: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post api_v1_tasks_url,
               params: { task: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Task, :count).by(0)
      end

      it "renders a JSON response with errors for the new task" do
        post api_v1_tasks_url,
             params: { task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { 
          name: 'Test task',
          description: '',
          start_date: 1.day.ago,
          end_date: 5.day.from_now,
          priority: DEFAULT_PRIORITIES[:normal],
          current_hours: 1.0,
          project_id: @project.id,
          user_id: @user.id
        }
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch api_v1_task_url(task),
              params: { task: new_attributes }, headers: valid_headers, as: :json
        task.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the task" do
        task = Task.create! valid_attributes
        patch api_v1_task_url(task),
              params: { task: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the task" do
        task = Task.create! valid_attributes
        patch api_v1_task_url(task),
              params: { task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete api_v1_task_url(task), headers: valid_headers, as: :json
      }.to change(Task, :count).by(-1)
    end
  end
end
