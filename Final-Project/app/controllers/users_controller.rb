class UsersController < ApplicationController
  before_action :authenticate_user! # Ensure only logged-in users can access
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_teacher, only: [:index, :destroy] # Optional: Admin-only actions

   def index
    @users = User.all
  end

  def show
    # @user is already set by `set_user`
  end

  def edit
    # @user is already set by `set_user`
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role) # Include fields you want users to update
  end

  def ensure_teacher
    redirect_to root_path, alert: "Access denied." unless current_user.role == "teacher"
  end
end
