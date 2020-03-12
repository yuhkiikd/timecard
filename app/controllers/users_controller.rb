class UsersController < ApplicationController
  before_action :logged_in?
  before_action :ensure_admin, except: [:show]
  before_action :ensure_current_user, only: [:show, :status]
  before_action :set_users, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index, :status, :show]

  def index
    @users = User.all
  end

  def status
    @status = TimeCard.where(year: @year, month: @month, day: @day)
  end

  def show
    @days = TimeCard.where(year: @year, month: @month, user_id: @user.id).order(day: "ASC").pluck(:worked_in_at).map{ |item| item.strftime('%Y/%m/%d')}
    @times = TimeCard.where(year: @year, month: @month, user_id: @user.id).order(day: "ASC").pluck(:overtime).map{ |item| Time.at(item).strftime('%X:%M').to_i}
    @worked_time = TimeCard.where(year: @year, month: @month, user_id: @user.id).sum(:worked_time)
    @overtime = TimeCard.where(year: @year, month: @month, user_id: @user.id).sum(:overtime)
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: "ユーザーを削除しました"
    elsif @user.errors.any?
      redirect_to users_path, alert: "管理者は最低1人必要です"
    else
      redirect_to users_path, alert: "ユーザー削除できませんでした"
    end
  end

  private

  def set_users
    @user = User.find(params[:id])
  end
end