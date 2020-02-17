# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :sign_in_required, only: [:show]
  before_action :ensure_current_user_admin

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_session_path
    else
      render :new
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def sign_in_status
    unless user_signed_in
      redirect_to new_user_session_path
    end
  end

  def ensure_current_user_admin
    if user_signed_in? == false
      redirect_to new_user_session_path
      flash[:danger] = "ログインしてください"
    elsif current_user.admin? == false
      redirect_to affiliations_path
      flash[:danger] = "管理者権限がありません"
    end
  end

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :affiliation_id)
  end
end
