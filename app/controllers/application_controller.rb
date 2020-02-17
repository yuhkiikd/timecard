class ApplicationController < ActionController::Base
  include AffiliationHelper

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  private

  def ensure_current_user_admin
    if user_signed_in? == false
      redirect_to new_user_session_path
      flash[:danger] = "ログインしてください"
    elsif current_user.admin? == false
      redirect_to affiliations_path
      flash[:danger] = "管理者権限がありません"
    end
  end

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end
end