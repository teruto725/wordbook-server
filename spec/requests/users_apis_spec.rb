require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Post /login" do
    before do
      @user = create(:user)
    end
  end
end