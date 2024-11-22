class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user=User.find_by_id(params['id'])
    if @user.nil?
      flash[:alert] = 'User not found.'
      redirect_to users_path
    end
  end

  def create
    @user= User.new(user_params)
    if @user.save
      flash[:success] = 'Hello and welcome!'
      redirect_to user_path(@user), notice: 'User was successfully created'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User was sucessfully updated"
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User was successfully deleted"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation :role)
  end
end
