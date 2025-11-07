class CreateVisions < ActiveRecord::Migration[8.0]
  def change
    create_table :visions do |t|
      t.string :name

      t.timestamps
    end
  end
end
