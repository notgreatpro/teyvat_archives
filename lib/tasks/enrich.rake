namespace :characters do
  desc "Import/enrich characters from API"
  task import_api: :environment do
    CharacterApiImporter.new.import
  end
end