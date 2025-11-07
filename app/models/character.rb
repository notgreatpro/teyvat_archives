class Character < ApplicationRecord
  belongs_to :region
  belongs_to :weapon_type
  belongs_to :vision
  belongs_to :arkhe, optional: true

  has_many :character_affiliations
  has_many :affiliations, through: :character_affiliations
  has_one :special_dish
  has_many :voice_actors

  validates :name, presence: true
  validates :star_rarity, presence: true, inclusion: { in: [4, 5] }
end
