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
        render json: { error: 'user_create_error' }, status: :unprocessable_entity
      end
    end

    private
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end

#1:11DZZCH_E_gpHDjuQDGS