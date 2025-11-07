class CreateCharacters < ActiveRecord::Migration[8.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :star_rarity
      t.date :release_date
      t.string :birthday
      t.string :model
      t.string :constellation
      t.references :vision, null: false, foreign_key: true
      t.references :arkhe, null: false, foreign_key: true
      t.references :weapon_type, null: false, foreign_key: true
      t.references :region, null: false, foreign_key: true
      t.string :ascension_specialty
      t.string :ascension_boss_material

      t.timestamps
    end
  end
end
