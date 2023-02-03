require "open-uri"
require 'json'
require 'watir'
require 'dotenv/load'

def scrape_students(batch, output_path)
  students = []
  url = "https://kitt.lewagon.com/camps/#{batch}/classmates"

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

  students = browser.divs('data-id': true).map do |student|
    { 
      name: student.element(tag_name: "strong", class: "!smaller").text.split.first,
      img: student.img(class: "img-thumbnail").src 
    }
  end

  students = students.shuffle.each_slice(4).to_a

  File.open(output_path, "wb") do |file|
    file.write(JSON.generate(students))
  end

  browser.close
end