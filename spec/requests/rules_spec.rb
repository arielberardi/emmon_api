require 'rails_helper'
require 'factories/rule'

RSpec.describe "api/v1/rules", type: :request do

  let(:valid_attributes) {
    FactoryBot.attributes_for(:rule)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:rule, section: nil)
  }

  let(:valid_headers) {
    headers = sign_up_and_sign_in user_attributes
  }

  describe "GET /index" do
    it "renders a successful response" do
      Rule.create! valid_attributes
      get api_v1_rules_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      rule = Rule.create! valid_attributes
      get api_v1_rule_url(rule), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Rule" do
        expect {
          post api_v1_rules_url,
              params: { rule: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Rule, :count).by(1)
      end

      it "renders a JSON response with the new rule" do
        post api_v1_rules_url,
             params: { rule: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Rule" do
        expect {
          post api_v1_rules_url,
               params: { rule: invalid_attributes }, headers: valid_headers, as: :json
        }.to change(Rule, :count).by(0)
      end

      it "renders a JSON response with errors for the new rule" do
        post api_v1_rules_url,
             params: { rule: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        FactoryBot.attributes_for(:rule, section: 'Department')
      }

      it "updates the requested rule" do
        rule = Rule.create! valid_attributes
        patch api_v1_rule_url(rule),
              params: { rule: new_attributes }, headers: valid_headers, as: :json
        rule.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the rule" do
        rule = Rule.create! valid_attributes
        patch api_v1_rule_url(rule),
              params: { rule: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the rule" do
        rule = Rule.create! valid_attributes
        patch api_v1_rule_url(rule),
              params: { rule: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested rule" do
      rule = Rule.create! valid_attributes
      expect {
        delete api_v1_rule_url(rule), headers: valid_headers, as: :json
      }.to change(Rule, :count).by(-1)
    end
  end
end
