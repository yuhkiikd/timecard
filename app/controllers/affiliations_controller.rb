class AffiliationsController < ApplicationController
  before_action :logged_in?
  before_action :ensure_admin, only: [:index, :new, :edit, :destroy]
  before_action :set_affiliation, only: [:edit,:show ,:update, :destroy]
  
  def index
    @affiliations = Affiliation.all
  end

  def new
    @affiliation = Affiliation.new
  end

  def create
    @affiliation = Affiliation.new(affiliation_params)
    if @affiliation.save
      redirect_to affiliations_path
    else
      render :new
    end
  end

  def update
    if @affiliation.update(affiliation_params)
      redirect_to affiliations_path
    else
      render :edit
    end
  end

  def show
    @days = TimeCard.where(affiliation_id: @affiliation.id).group(:year,:month, :day).order(day: "ASC").minimum(:worked_in_at).values.map{ |item| item.strftime('%Y/%m/%d')}
    @times = TimeCard.where(affiliation_id: @affiliation.id).group(:year,:month, :day).order(day: "ASC").sum(:overtime).values.map{ |item| Time.at(item).strftime('%X:%M').to_i}
  end

  def edit
  end

  def destroy
    if @affiliation.destroy
      redirect_to affiliations_path, notice: "所属を削除しました"
    elsif @affiliation.valid?
      redirect_to affiliations_path, alert: "所属ユーザーまたは所属に紐付くタイムカードがあるため削除できません"
    else
      redirect_to affiliations_path, alert: "削除できませんでした"
    end
  end
end

private

def set_affiliation
  @affiliation = Affiliation.find(params[:id])
end

def affiliation_params
  params.require(:affiliation).permit(:name)
end