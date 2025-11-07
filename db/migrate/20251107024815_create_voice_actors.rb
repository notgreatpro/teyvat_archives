class CreateVoiceActors < ActiveRecord::Migration[8.0]
  def change
    create_table :voice_actors do |t|
      t.references :character, null: false, foreign_key: true
      t.string :language_code
      t.string :name

      t.timestamps
    end
  end
end
