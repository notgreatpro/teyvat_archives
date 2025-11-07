class CreateSpecialDishes < ActiveRecord::Migration[8.0]
  def change
    create_table :special_dishes do |t|
      t.string :name
      t.references :character, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
