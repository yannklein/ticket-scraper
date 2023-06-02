require_relative "scripts/scrape_tickets.rb"
require_relative "scripts/generate_teams.rb"

task :scrape_tickets, :batch do |task, arg|
  if arg[:batch].nil?
    puts "Missing batch number (example: rake 'build_page[1105]')"
    exit
  end
  scrape_tickets(arg[:batch], "data.json")
end