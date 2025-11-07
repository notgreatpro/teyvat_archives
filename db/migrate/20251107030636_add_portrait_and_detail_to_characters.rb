class AddPortraitAndDetailToCharacters < ActiveRecord::Migration[8.0]
  def change
    add_column :characters, :portrait, :string
    add_column :characters, :detail, :text
  end
end
