# app/services/character_api_importer.rb
class CharacterApiImporter
  API_ENDPOINT = 'https://genshin.jmp.blue/characters' # Adjust as needed

  def import
    require 'httparty'
    response = HTTParty.get(API_ENDPOINT)
    data = response.parsed_response

    found = 0
    enriched = 0
    not_found = 0
    data.each do |api_char|
      # Prefer to match by slug if possible
      character = Character.find_by(slug: api_char["slug"])     ||
                  Character.find_by(name: api_char["name"])      # Fallback if slug match fails

      if character
        found += 1
        # Enrich logic: update/add any additional fields,
        # e.g. character.description ||= api_char["description"]
        enriched += 1 if character.changed? && character.save
      else
        not_found += 1
        puts "No character in DB for slug/name: #{api_char["slug"] || api_char["name"]}"
      end
    end

    puts "API Enrichment Done. Found: #{found}, Enriched: #{enriched}, Not found: #{not_found}"
  end
end