require "rails_helper"

RSpec.describe "Accounts API", type: :request do
  describe "GET /api/v1/accounts" do
    let (:user) { build(:user) }
  #   # let (:accounts) { create_list(:account, 10) }
  #   # let (:account_id) { accounts.first.id }

    context "when the request with NO authentication header" do
      it "should return unauth for retrieve current user info before login" do
        get "/api/v1/accounts"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    # context "when the request contains an authentication header" do
    #   before { get "/api/v1/accounts", headers: authenticated_header(user) }

    #   it "should return the user info" do
    #     expect(json).not_to be_empty
    #     expect(json.size).to eq(10)
    #   end

    #   it "returns status code 200" do
    #     expect(response).to have_http_status(:ok)
    #   end
    # end

  #   describe "GET /api/v1/accounts/:id" do
  #     before { get "/api/v1/accounts/#{account_id}" }

  #     context "when the record exists" do
  #       it "returns the account" do
  #         expect(json).not_to be_empty
  #         expect(json["id"]).to eq(account_id)
  #       end

  #       it "returns status code 200" do
  #         expect(response).to have_http_status(:ok)
  #       end
  #     end

  #     context "when the record does not exist" do
  #       let(:account_id) { 100 }

  #       it "returns status code 404" do
  #         expect(response).to have_http_status(404)
  #       end

  #       it "returns a not found message" do
  #         expect(response.body).to match("{\"message\":\"Couldn't find Account with 'id'=100\"}")
  #       end
  #     end
  #   end
  end
end
