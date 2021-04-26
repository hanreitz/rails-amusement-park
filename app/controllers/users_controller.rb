class UsersController < ApplicationController
  before_action :restricted_area, only: [:show]
  def home
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user == nil
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :admin, :password)
  end
end
