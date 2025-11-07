require 'httparty'

namespace :genshin do
  desc "Fetch full character details from Genshin Impact API and enrich database"
  task import_api: :environment do
    base_url = 'https://genshin.jmp.blue/characters'
    slugs = HTTParty.get(base_url)

    unless slugs.code == 200
      puts "API fetch failed: #{slugs.code}"
      exit(1)
    end

    character_slugs = slugs.parsed_response

    character_slugs.each do |slug|
      detail_url = "#{base_url}/#{slug}"
      detail_response = HTTParty.get(detail_url)
      unless detail_response.code == 200
        puts "Failed to fetch details for #{slug}: #{detail_response.code}"
        next
      end

      api_data = detail_response.parsed_response

      api_name = api_data["name"]
      # Sluggify your DB names for matching
      def to_slug(str)
        str.to_s.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '')
      end

      # Try to match by direct name (case-insensitive and trimmed)
      character = Character.where("LOWER(name) = ?", api_name.to_s.strip.downcase).first
      # If not found, match with slug conversion
      if character.nil?
        character = Character.where("LOWER(REPLACE(name, ' ', '-')) = ?", slug.downcase).first
      end
      # If not found, try slugging the DB names and compare
      if character.nil?
        character = Character.all.find { |c| to_slug(c.name) == slug }
      end

      puts "Matching: API name '#{api_name}', slug '#{slug}' -> #{character ? "Found: #{character.name}" : "Not found"}"

      if character
        # Example enrichment! Add portrait/description columns if needed
        character.update(
          portrait: api_data['icon'],
          detail: api_data['description']
          # Add other fields here
        )
        puts "Updated: #{character.name} (#{slug})"
      else
        puts "Character not found for API import (#{api_name} / #{slug})"
      end
    end
    puts "API import complete."
  end
end