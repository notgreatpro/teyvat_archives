class ChangeArkheIdNullableInCharacters < ActiveRecord::Migration[8.0]
  def change
    change_column_null :characters, :arkhe_id, true
  end
end
