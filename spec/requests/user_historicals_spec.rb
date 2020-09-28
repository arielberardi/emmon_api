require 'rails_helper'

RSpec.describe "api/v1/user_historicals", type: :request do

  before do
    @headers = sign_up_and_sign_in user_attributes
    @user = User.find_by(email: 'fake@gmail.com')
  end

  let(:valid_attributes) {
    {
      start_date: Time.now,
      end_date: 1.day.from_now,
      description: '',
      user_id: @user.id
    }
  }

  let(:invalid_attributes) {
    {
      start_date: 1.day.from_now,
      end_date: Time.now,
      description: '',
      user_id: @user.id
    }
  }

  let(:valid_headers) {
    @headers
  }

  describe "GET /index" do
    it "renders a successful response" do
      UserHistorical.create! valid_attributes
      get api_v1_user_historicals_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user_historical = UserHistorical.create! valid_attributes
      get api_v1_user_historical_url(user_historical), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UserHistorical" do
        expect {
          post api_v1_user_historicals_url,
               params: { user_historical: valid_attributes }, headers: valid_headers, as: :json
        }.to change(UserHistorical, :count).by(1)
      end

      it "renders a JSON response with the new user_historical" do
        post api_v1_user_historicals_url,
             params: { user_historical: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UserHistorical" do
        expect {
          post api_v1_user_historicals_url,
               params: { user_historical: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(UserHistorical, :count).by(0)
      end

      it "renders a JSON response with errors for the new user_historical" do
        post api_v1_user_historicals_url,
             params: { user_historical: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          start_date: Time.now,
          end_date: 5.day.from_now,
          description: '',
          user_id: @user.id
        }
      }

      it "updates the requested user_historical" do
        user_historical = UserHistorical.create! valid_attributes
        patch api_v1_user_historical_url(user_historical),
              params: { user_historical: new_attributes }, headers: valid_headers, as: :json
        user_historical.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the user_historical" do
        user_historical = UserHistorical.create! valid_attributes
        patch api_v1_user_historical_url(user_historical),
              params: { user_historical: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user_historical" do
        user_historical = UserHistorical.create! valid_attributes
        patch api_v1_user_historical_url(user_historical),
              params: { user_historical: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user_historical" do
      user_historical = UserHistorical.create! valid_attributes
      expect {
        delete api_v1_user_historical_url(user_historical), headers: valid_headers, as: :json
      }.to change(UserHistorical, :count).by(-1)
    end
  end
end
