module SearchActions
  extend ActiveSupport::Concern

  def search_action
    if !params[:year] && !params[:month] || params[:year] == "" || params[:month] == ""
      redirect_to time_cards_path
    elsif !!params[:year] && !!params[:month]
      @year = params[:year].to_i
      @month = params[:month].to_i
      @time_cards = monthly_time_cards(current_user, @year, @month)
      render :index
    end
  end
end