require 'rails_helper'

RSpec.describe "Wordbooks", type: :request do
  describe "Get" do
    before do
      @users = create_list(:user,2)
    end
    it 'Wordbooksを追加できるか' do
      post "/v1/wordbooks", headers: {Authorization: @users[0].access_token}, params: {name: "book1"}
      expect(response.status).to eq(200)
    end
    it 'Wordbooks一覧見れるか' do
      get "/v1/wordbooks", headers: {Authorization: @users[0].access_token}
      expect(response.status).to eq(200)
    end
    it 'Wordbooks消せるか' do
      post "/v1/wordbooks", headers: {Authorization: @users[0].access_token}, params: {name: "book1"}
      expect(response.status).to eq(200)
      id = json["id"]
      delete "/v1/wordbooks/#{id}", headers: {Authorization: @users[0].access_token}
      expect(response.status).to eq(200)
    end
    it "mostdiffできるか" do
      post "/v1/wordbooks", headers: {Authorization: @users[0].access_token}, params: {name: "book1"}
      expect(response.status).to eq(200)
      id = json["id"]
      post "/v1/wordbooks/#{id}/words", headers: {Authorization: @users[0].access_token}, params: {english: "test",japanese: "テスト"}
      expect(response.status).to eq(200)
      expect(json["english"]).to eq("test")
      get "/v1/wordbooks/#{id}/most_diff", headers: {Authorization: @users[0].access_token}
      expect(response.status).to eq(200)
      expect(json["english"]).to eq("test")
    end
  end
end