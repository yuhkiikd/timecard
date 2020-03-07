class UsersController < ApplicationController
  before_action :logged_in?
  before_action :ensure_admin, except: [:show]
  before_action :ensure_current_user, only: [:index, :show, :status]
  before_action :set_users, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:status, :show]

  def index
    @users = User.all
  end

  def status
    @status = TimeCard.where(year: @year, month: @month, day: @day).or(TimeCard.where(worked_in_at: nil))
  end

  def show
    @days = TimeCard.where(year: @year, month: @month, user_id: @user.id).order(day: "ASC").pluck(:worked_in_at).map{ |item| item.strftime('%Y/%m/%d')}
    @times = TimeCard.where(year: @year, month: @month, user_id: @user.id).order(day: "ASC").pluck(:overtime).map{ |item| Time.at(item).strftime('%X:%M').to_i}
  end

  def edit
  end

  def update
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: "アカウントを削除しました"
    elsif @user.errors.any?
      redirect_to users_path
      @user.errors.full_messages.each do |msg|
        flash[:alert] = msg
      end
    end
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