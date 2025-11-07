class CreateWeaponTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :weapon_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
