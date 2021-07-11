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
    it 'Wordbooksshowできるか' do
      post "/v1/wordbooks", headers: {Authorization: @users[0].access_token}, params: {name: "book1"}
      expect(response.status).to eq(200)
      id = json["id"]
      get "/v1/wordbooks/#{id}", headers: {Authorization: @users[0].access_token}
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

    it "successできるか" do
      post "/v1/wordbooks", headers: {Authorization: @users[0].access_token}, params: {name: "book1"}
      expect(response.status).to eq(200)
      id = json["id"]
      post "/v1/wordbooks/#{id}/words", headers: {Authorization: @users[0].access_token}, params: {english: "test",japanese: "テスト"}
      expect(response.status).to eq(200)
      expect(json["english"]).to eq("test")
      post "/v1/wordbooks/#{id}/words", headers: {Authorization: @users[0].access_token}, params: {english: "test2",japanese: "テスト2"}
      expect(response.status).to eq(200)
      expect(json["english"]).to eq("test2")
      get "/v1/wordbooks/#{id}/most_diff", headers: {Authorization: @users[0].access_token}
      expect(response.status).to eq(200)
      word_id = json["id"]
      word_en = json["english"]
      get "/v1/wordbooks/#{id}/words/#{word_id}/success", headers: {Authorization: @users[0].access_token}
      expect(response.status).to eq(200)
      expect(json[id]).to_not eq word_id
    end
    it "word deleteできるか" do
      post "/v1/wordbooks", headers: {Authorization: @users[0].access_token}, params: {name: "book1"}
      expect(response.status).to eq(200)
      id = json["id"]
      post "/v1/wordbooks/#{id}/words", headers: {Authorization: @users[0].access_token}, params: {english: "test",japanese: "テスト"}
      expect(response.status).to eq(200)
      expect(json["english"]).to eq("test")
      word_id = json["id"]
      delete "/v1/wordbooks/#{id}/words/#{word_id}", headers: {Authorization: @users[0].access_token}
      expect(response.status).to eq(200)
      expect(json["id"]).to eq(word_id)
    end
  end
end