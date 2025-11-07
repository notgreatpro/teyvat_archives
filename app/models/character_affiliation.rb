class CharacterAffiliation < ApplicationRecord
  belongs_to :character
  belongs_to :affiliation
end
