# app/controllers/regions_controller.rb
class RegionsController < ApplicationController
  def index
    @regions = Region.all.order(:name)
  end

  def show
    @region = Region.find(params[:id])
    @characters = @region.characters.includes(:vision, :weapon_type)
                        .order(:name)
                        .page(params[:page])
                        .per(20)
  end
end