class CreateArkhes < ActiveRecord::Migration[8.0]
  def change
    create_table :arkhes do |t|
      t.string :name

      t.timestamps
    end
  end
end
