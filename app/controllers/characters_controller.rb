# app/controllers/characters_controller.rb
class CharactersController < ApplicationController
  def index
    @characters = Character.includes(:region, :vision, :weapon_type)
                          .order(:name)
    
    # Simple text search
    if params[:q].present?
      @characters = @characters.where("name ILIKE ?", "%#{params[:q]}%")
    end
    
    # Hierarchical search - filter by region
    if params[:region_id].present?
      @characters = @characters.where(region_id: params[:region_id])
    end
    
    # Filter by vision
    if params[:vision_id].present?
      @characters = @characters.where(vision_id: params[:vision_id])
    end
    
    # Filter by weapon type
    if params[:weapon_type_id].present?
      @characters = @characters.where(weapon_type_id: params[:weapon_type_id])
    end
    
    # Pagination
    @characters = @characters.page(params[:page]).per(20)
  end

  def show
    @character = Character.includes(:region, :vision, :weapon_type, :arkhe,
                                   :affiliations, :voice_actors, :special_dish)
                         .find(params[:id])
  end
end