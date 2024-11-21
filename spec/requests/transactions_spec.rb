require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/transactions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /credit" do
    it "returns http success" do
      get "/transactions/credit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /debit" do
    it "returns http success" do
      get "/transactions/debit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /transfer" do
    it "returns http success" do
      get "/transactions/transfer"
      expect(response).to have_http_status(:success)
    end
  end

end
