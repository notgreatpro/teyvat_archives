# app/controllers/visions_controller.rb
class VisionsController < ApplicationController
  def index
    @visions = Vision.all.order(:name)
  end

  def show
    @vision = Vision.find(params[:id])
    @characters = @vision.characters.includes(:region, :weapon_type)
                        .order(:name)
                        .page(params[:page])
                        .per(20)
  end
end