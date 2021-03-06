require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
      students.push(:name=>student.css(".student-name").text,
      :location=>student.css(".student-location").text,
      :profile_url=>student.css('a').attribute("href").value)
    end
    students
  end

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
      students.push(:name=>student.css(".student-name").text,
      :location=>student.css(".student-location").text,
      :profile_url=>student.css('a').attribute("href").value)
    end
    students
  end



  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css('.social-icon-container a').map {|e| e['href']}.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = doc.css('.profile-quote').text
    student[:bio] = doc.css('.description-holder p').text
    student
  end
end
