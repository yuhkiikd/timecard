class UsersController < ApplicationController
  before_action :logged_in?, only: [:index, :show, :status]
  before_action :ensure_admin, only: [:status]
  before_action :ensure_current_user, only: [:index, :show, :status]
  before_action :set_users, only: [:show]
  before_action :set_date, only: [:status, :show]

  def status
    @status = TimeCard.where(year: @year, month: @month, day: @day)
  end

  def show
    @days = TimeCard.where(year: @year, month: @month, user_id: @user.id).order(day: "ASC").pluck(:worked_in_at).map{ |item| item.strftime('%Y/%m/%d')}
    @times = TimeCard.where(year: @year, month: @month, user_id: @user.id).order(day: "ASC").pluck(:overtime).map{ |item| Time.at(item).strftime('%X:%M').to_i}
  end

  private

  def set_users
    @user = User.find(params[:id])
  end

  def set_date
    today = Date.current
    @year = today.year
    @month = today.month
    @day = today.day
  end
end