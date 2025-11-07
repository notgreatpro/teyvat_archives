class CreateRegions < ActiveRecord::Migration[8.0]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :archon
      t.text :description

      t.timestamps
    end
  end
end
