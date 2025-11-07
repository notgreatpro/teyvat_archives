# app/controllers/affiliations_controller.rb
class AffiliationsController < ApplicationController
  def index
    @affiliations = Affiliation.all.order(:name)
  end

  def show
    @affiliation = Affiliation.find(params[:id])
    @characters = @affiliation.characters.includes(:region, :vision, :weapon_type)
                              .order(:name)
                              .page(params[:page])
                              .per(20)
  end
end