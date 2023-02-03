require_relative "scripts/scrape_students.rb"
require_relative "scripts/generate_teams.rb"

task :scrape_students, :batch do |task, arg|
  if arg[:batch].nil?
    puts "Missing batch number (example: rake 'build_page[1105]')"
    exit
  end
  scrape_students(arg[:batch], "data.json")
end

task :generate do
  generate("data.json", "index.html.erb", "index.html")
end

task :build_page, :batch do |task, arg| 
  Rake::Task['scrape_students'].execute({batch: arg[:batch]})
  Rake::Task['generate'].execute
end