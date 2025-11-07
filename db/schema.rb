# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_07_044944) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "affiliations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arkhes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_affiliations", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "affiliation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliation_id"], name: "index_character_affiliations_on_affiliation_id"
    t.index ["character_id"], name: "index_character_affiliations_on_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "star_rarity"
    t.date "release_date"
    t.string "birthday"
    t.string "model"
    t.string "constellation"
    t.bigint "vision_id", null: false
    t.bigint "arkhe_id"
    t.bigint "weapon_type_id", null: false
    t.bigint "region_id", null: false
    t.string "ascension_specialty"
    t.string "ascension_boss_material"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "portrait"
    t.text "detail"
    t.string "slug"
    t.index ["arkhe_id"], name: "index_characters_on_arkhe_id"
    t.index ["region_id"], name: "index_characters_on_region_id"
    t.index ["slug"], name: "index_characters_on_slug", unique: true
    t.index ["vision_id"], name: "index_characters_on_vision_id"
    t.index ["weapon_type_id"], name: "index_characters_on_weapon_type_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "archon"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_dishes", force: :cascade do |t|
    t.string "name"
    t.bigint "character_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_special_dishes_on_character_id"
  end

  create_table "visions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voice_actors", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "language_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_voice_actors_on_character_id"
  end

  create_table "weapon_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "character_affiliations", "affiliations"
  add_foreign_key "character_affiliations", "characters"
  add_foreign_key "characters", "arkhes"
  add_foreign_key "characters", "regions"
  add_foreign_key "characters", "visions"
  add_foreign_key "characters", "weapon_types"
  add_foreign_key "special_dishes", "characters"
  add_foreign_key "voice_actors", "characters"
end
