class Affiliation < ApplicationRecord
  has_many :character_affiliations
  has_many :characters, through: :character_affiliations
end
