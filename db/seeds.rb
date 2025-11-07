# db/seeds.rb
require "csv"

puts "🌟 Clearing existing data..."
CharacterAffiliation.destroy_all
VoiceActor.destroy_all
SpecialDish.destroy_all
Character.destroy_all
Affiliation.destroy_all
Region.destroy_all
WeaponType.destroy_all
Vision.destroy_all
Arkhe.destroy_all

puts "📦 Seeding foundational data..."

# Create Regions (including special ones)
regions_data = ["Mondstadt", "Liyue", "Inazuma", "Sumeru", "Fontaine", "Natlan", "Snezhnaya", "Unknown", "Outlander"]
regions_data.each { |name| Region.create!(name: name) }

# Create Weapon Types
weapon_types = ["Sword", "Bow", "Claymore", "Polearm", "Catalyst"]
weapon_types.each { |name| WeaponType.create!(name: name) }

# Create Visions (Elements)
visions = ["Pyro", "Hydro", "Anemo", "Electro", "Dendro", "Cryo", "Geo"]
visions.each { |name| Vision.create!(name: name) }

# Create Arkhe types (Fontaine + special cases)
["Pneuma", "Ousia", "Outlander", "Outsider"].each { |name| Arkhe.create!(name: name) }

puts "📄 Importing CSV data..."
csv_path = Rails.root.join("csv_data", "genshin_characters_v1.csv")

unless File.exist?(csv_path)
  puts "❌ ERROR: CSV file not found at #{csv_path}"
  exit
end

success_count = 0
error_count = 0

CSV.foreach(csv_path, headers: true) do |row|
  begin
    # Get character name
    name = row["character_name"]
    
    if name.blank?
      puts "⚠️  Skipping row - no character name"
      error_count += 1
      next
    end
    
    # Get star rarity with validation
    star_rarity = row["star_rarity"].to_i
    if star_rarity < 4 || star_rarity > 5
      puts "⚠️  Invalid rarity for #{name}, defaulting to 4"
      star_rarity = 4
    end
    
    # Handle missing region - assign "Outlander" for Travelers, "Unknown" for others
    region_name = row["region"]
    if region_name.blank?
      region_name = name.include?("Traveler") ? "Outlander" : "Unknown"
      puts "ℹ️  Assigning region '#{region_name}' to #{name}"
    end
    region = Region.find_or_create_by!(name: region_name)
    
    # Get vision (required)
    vision_name = row["vision"]
    if vision_name.blank?
      puts "⚠️  Skipping #{name} - missing vision"
      error_count += 1
      next
    end
    vision = Vision.find_or_create_by!(name: vision_name)
    
    # Get weapon type (required)
    weapon_name = row["weapon_type"]
    if weapon_name.blank?
      puts "⚠️  Skipping #{name} - missing weapon type"
      error_count += 1
      next
    end
    weapon_type = WeaponType.find_or_create_by!(name: weapon_name)
    
    # Handle Arkhe (optional)
    arkhe = nil
    if row["arkhe"].present?
      arkhe = Arkhe.find_or_create_by!(name: row["arkhe"])
    end
    
    # Create character
    character = Character.create!(
      name: name,
      star_rarity: star_rarity,
      release_date: row["release_date"],
      birthday: row["birthday"],
      model: row["model"],
      constellation: row["constellation"],
      vision: vision,
      region: region,
      weapon_type: weapon_type,
      arkhe: arkhe,
      ascension_specialty: row["ascension_specialty"],
      ascension_boss_material: row["ascension_boss_material"]
    )
    
    # Affiliations (many-to-many)
    if row["affiliation"].present?
      row["affiliation"].split(/[,;]/).map(&:strip).each do |affil|
        next if affil.blank?
        affiliation = Affiliation.find_or_create_by!(name: affil)
        CharacterAffiliation.find_or_create_by!(character: character, affiliation: affiliation)
      end
    end
    
    # Special Dish
    if row["special_dish"].present?
      SpecialDish.create!(
        name: row["special_dish"],
        character: character,
        description: "Special dish for #{name}"
      )
    end
    
    # Voice Actors
    {
      "EN" => "voice_en",
      "CN" => "voice_cn",
      "JP" => "voice_jp",
      "KR" => "voice_kr"
    }.each do |lang, col|
      va_name = row[col]
      next if va_name.blank?
      VoiceActor.create!(
        character: character,
        language_code: lang,
        name: va_name
      )
    end
    
    success_count += 1
    puts "✅ Created: #{character.name}"
    
  rescue => e
    error_count += 1
    puts "❌ Error creating character: #{e.message}"
    puts "   Row: #{row['character_name']}"
  end
end

puts "\n🎉 Seeding complete!"
puts "✅ Successfully created: #{success_count} characters"
puts "❌ Errors: #{error_count}" if error_count > 0
puts "📊 Total characters in DB: #{Character.count}"
puts "📊 Total regions: #{Region.count}"
puts "📊 Total affiliations: #{Affiliation.count}"