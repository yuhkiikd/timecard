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
    @affiliations = Affiliation.all
    @worked_time = @affiliation.time_card.where(year:2020,month:3).sum(:worked_time)
  end

  def edit
  end

  def destroy
    if @affiliation.destroy
      redirect_to affiliations_path, notice: "アカウントを削除しました"
    else
      redirect_to affiliations_path, notice: "所属ユーザーがいるため削除できません"
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