require 'rails_helper'

RSpec.describe "Wallets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/wallets/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/wallets/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /balance" do
    it "returns http success" do
      get "/wallets/balance"
      expect(response).to have_http_status(:success)
    end
  end

end
