require "rails_helper"

RSpec.describe Api::V1::UserTeamsController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(get: "/api/v1/user_teams").to route_to("api/v1/user_teams#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/user_teams/1").to route_to("api/v1/user_teams#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/api/v1/user_teams").to route_to("api/v1/user_teams#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/user_teams/1").to route_to("api/v1/user_teams#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/user_teams/1").to route_to("api/v1/user_teams#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/user_teams/1").to route_to("api/v1/user_teams#destroy", id: "1")
    end

  end
end
