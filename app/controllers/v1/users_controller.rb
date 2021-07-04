module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST
    # Create an user
    def create
      @user = User.new user_params

      if @user.save!
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    private
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end


# signup
# curl localhost:3000/v1/users --data '{"user": {"email": "user2@example.com", "password": "mypass"}}' -v -H "Accept: application/json" -H "Content-type: application/json"
# login
# curl localhost:3000/v1/login --data 'email=user2@example.com&password=mypass'
#