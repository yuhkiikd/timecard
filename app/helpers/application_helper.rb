module ApplicationHelper

  def ensure_admin
    unless current_user.try(:admin?)
      unless current_user.admin?
        redirect_to time_cards_path, alert: '管理者権限がありません'
      end
    end
  end

  def logged_in?
    unless current_user.present?
      redirect_to new_user_session_path, notice: 'ログアウト済です'
    end
  end

  def ensure_current_user
    unless current_user.try(:admin?)
      if current_user.id != params[:id].to_i
        redirect_to time_cards_path, alert: 'アクセス権がありません'
      end
    end
  end
end