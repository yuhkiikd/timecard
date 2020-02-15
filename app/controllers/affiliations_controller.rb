class AffiliationsController < ApplicationController
  def index
    @affiliations = Affiliation.all
  end

  def new
    @affiliation = Affiliation.new
  end

  def create
    Affiliation.create(affiliation_params)
    redirect_to affiliations_path
  end

  def update
  end

  def edit
  end

  def destroy
  end
end

private

def affiliation_params
  params.require(:affiliation).permit(:name)
end