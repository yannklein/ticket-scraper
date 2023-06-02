require "open-uri"
require 'json'
require 'watir'
require 'dotenv/load'
# require "watir-webdriver/wait"

def scrape_tickets(batch, output_path)
  students = Hash.new(0)
  url = "https://kitt.lewagon.com/camps/#{batch}/tickets/day_dashboard"

  browser = Watir::Browser.new

  browser.goto url
  link = browser.div(class: 'sign-in-content').children(tag_name: "a").last
  link.click

  account_field = browser.text_field(id: 'login_field')
  account_field.set "yann.klein@me.com"

  account_field = browser.text_field(id: 'password')
  account_field.set ENV['GITHUB_KEY']

  link = browser.input(class: 'js-sign-in-button')
  link.click

  45.times do 
    Watir::Wait.until { browser.element(id: 'tickets-dashboard').present? }
    browser.divs(class: 'student-ticket-count-bar').each do |student_element|
      name = student_element.attribute('data-title').split(" - ")[0]
      ticket_count = student_element.attribute('data-title').split(" - ")[1].split(" ")[0].to_i
      students[name] += ticket_count
    end
    students['day'] += 1
    puts
    p students
    link = browser.div(class: 'change-day-link').children(tag_name: "a").first
    link.click
  end

  File.open(output_path, "wb") do |file|
    file.write(JSON.generate(students))
  end

  browser.close
end