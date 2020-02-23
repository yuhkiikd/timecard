class UsersController < ApplicationController
  before_action :set_users, only: [:show]

  def show
  end

  private

  def set_users
    @user = User.find(params[:id])
  end

  def ensure_current_user
    if logged_in? == false
      redirect_to new_session_path
      flash[:danger] = "ログインしてください"
    elsif current_user.id != params[:id].to_i
      redirect_to tasks_path
    end
  end
end