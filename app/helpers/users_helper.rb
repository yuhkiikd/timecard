module UsersHelper
  private

  def set_date
    today = Date.current
    @year = today.year
    @month = today.month
    @day = today.day
  end

  def set_year_and_month
    today = Date.current
    @year = today.year
    @month = today.month
  end

  def current_user_is_admin?
    user_signed_in? && current_user.admin?
  end
end