class AffiliationsController < ApplicationController
  PER = 10
  before_action :logged_in?
  before_action :ensure_admin, only: [:index, :new, :edit, :show, :destroy]
  before_action :set_affiliation, only: [:edit,:show ,:update, :destroy]
  before_action :set_affiliation_chart_data, only: [:show]
  
  def index
    @affiliations = Affiliation.all
  end

  def new
    @affiliation = Affiliation.new
  end

  def create
    @affiliation = Affiliation.new(affiliation_params)
    if @affiliation.save
      redirect_to affiliations_path, notice: "新しい所属を登録しました"
    else
      render :new
    end
  end

  def update
    if @affiliation.update(affiliation_params)
      redirect_to affiliations_path, notice: "所属を編集しました"
    else
      render :edit
    end
  end

  def show
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