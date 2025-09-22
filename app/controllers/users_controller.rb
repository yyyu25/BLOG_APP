class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def profile
    # Profile view - show current user's profile
  end

  def update_profile
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully!"
    else
      render :profile, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
