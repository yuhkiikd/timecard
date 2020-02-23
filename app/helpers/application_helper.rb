module ApplicationHelper

  def ensure_admin
    if logged_in?
      unless current_user.try(:admin?)
        unless current_user.admin?
          redirect_to user_path(current_user.id), notice: '管理者権限がありません'
        end
      end
    else
      redirect_to new_user_session_path, notice: 'ログインしてください'
    end
  end

  def logged_in?
    current_user.present?
  end
end