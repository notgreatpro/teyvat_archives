require "csv"

csv_path = Rails.root.join("csv_data", "genshin_characters_v1.csv")

CSV.foreach(csv_path, headers: true) do |row|
  # Skip rows missing required fields
  if row["character_name"].blank? || row["star_rarity"].blank? || row["region"].blank? || row["vision"].blank? || row["weapon_type"].blank? || row["slug"].blank?
    puts "Skipping row due to missing required fields: #{row.inspect}"
    next
  end

  region = Region.find_or_create_by(name: row["region"])
  vision = Vision.find_or_create_by(name: row["vision"])
  weapon_type = WeaponType.find_or_create_by(name: row["weapon_type"])

  # Handle nullable arkhe
  arkhe = row['arkhe'].blank? ? nil : Arkhe.find_or_create_by(name: row['arkhe'])

  character = Character.find_or_initialize_by(slug: row["slug"])
  character.name = row["character_name"]
  character.star_rarity = row["star_rarity"]
  character.release_date = row["release_date"]
  character.birthday = row["birthday"]
  character.model = row["model"]
  character.constellation = row["constellation"]
  character.vision = vision
  character.region = region
  character.weapon_type = weapon_type
  character.arkhe = arkhe
  character.ascension_specialty = row["ascension_specialty"]
  character.ascension_boss_material = row["ascension_boss_material"]
  character.save!

  # Affiliations (many-to-many)
  row["affiliation"].to_s.split(",").map(&:strip).each do |affil|
    next if affil.blank?
    affiliation = Affiliation.find_or_create_by(name: affil)
    CharacterAffiliation.find_or_create_by(character: character, affiliation: affiliation)
  end

  # Special Dish (unique or one-to-one)
  unless row["special_dish"].blank?
    SpecialDish.find_or_create_by(
      name: row["special_dish"],
      character: character,
      description: "" # Fill this if your CSV/row has dish descriptions
    )
  end

  # Voice Actors (EN, CN, JP, KR)
  {en: "voice_en", cn: "voice_cn", jp: "voice_jp", kr: "voice_kr"}.each do |lang, col|
    va_name = row[col]
    next if va_name.blank?
    VoiceActor.find_or_create_by(character: character, language_code: lang.to_s.upcase, name: va_name)
  end
end

puts "Finished seeding characters!"