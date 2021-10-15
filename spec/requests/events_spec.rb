require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /new" do
    xit "returns http success" do
      get "/events/new"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /create" do
    xit "returns http success" do
      get "/events/create"
      expect(response).to have_http_status(200)
    end
  end
end
