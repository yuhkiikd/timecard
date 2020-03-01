class AffiliationsController < ApplicationController
  before_action :logged_in?
  before_action :ensure_admin, only: [:new, :edit, :destroy]
  before_action :set_affiliation, only: [:edit, :update, :destroy]
  
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

  def edit
  end

  def destroy
    @affiliation.destroy
    redirect_to affiliations_path
  end
end

private

def set_affiliation
  @affiliation = Affiliation.find(params[:id])
end

def affiliation_params
  params.require(:affiliation).permit(:name)
end