class UsersController < ApplicationController
  before_action :set_users, only: [:show, :edit, :destroy, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to users_path
    flash[:success] = 'アカウントを削除しました'
  end

  private

  def set_users
    @user = User.find(params[:id])
  end
end