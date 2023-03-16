require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /deposit" do
    it "returns http success" do
      get "/api/v1/users/deposit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /withdraw" do
    it "returns http success" do
      get "/api/v1/users/withdraw"
      expect(response).to have_http_status(:success)
    end
  end

end
