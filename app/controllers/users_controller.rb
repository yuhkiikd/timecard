class UsersController < ApplicationController
  before_action :set_users, only: [:show]

  def show
    @days = TimeCard.order(worked_in_at: "ASC").first(2).pluck(:worked_in_at).map{ |item| item.strftime('%Y/%m/%d')}
    @times = TimeCard.pluck(:overtime).map{ |item| Time.at(item).strftime('%X:%M').to_i}
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