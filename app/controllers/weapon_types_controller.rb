# app/controllers/weapon_types_controller.rb
class WeaponTypesController < ApplicationController
  def index
    @weapon_types = WeaponType.all.order(:name)
  end

  def show
    @weapon_type = WeaponType.find(params[:id])
    @characters = @weapon_type.characters.includes(:region, :vision)
                             .order(:name)
                             .page(params[:page])
                             .per(20)
  end
end