module UsersHelper
  def set_date
    today = Date.current
    @year = today.year
    @month = today.month
    @day = today.day
  end
end