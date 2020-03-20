class UsersController < ApplicationController
  PER = 10
  before_action :logged_in?
  before_action :ensure_admin, except: [:show, :edit]
  before_action :ensure_current_user, only: [:show, :status]
  before_action :set_users, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index, :status, :show]
  before_action :set_user_chart_data, only: [:show]

  def index
    @users = User.page(params[:page]).per(PER).all.asc
  end

  def status
    @status = TimeCard.where(year: @year, month: @month, day: @day)
  end

  def show
  end

  def edit
    if current_user.id == @user.id
      redirect_to users_path, alert: "管理者は他の管理者から編集・削除をしてください"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @user.id && current_user.admin?
      redirect_to users_path, alert: "管理者は他の管理者から編集・削除をしてください"
    elsif @user.destroy
      redirect_to users_path, notice: "ユーザーを削除しました"
    else
      redirect_to users_path, alert: "管理者は最低1人必要です"
    end
  end

  private

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :affiliation_id, :admin)
  end
end