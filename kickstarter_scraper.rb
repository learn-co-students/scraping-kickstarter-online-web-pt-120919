# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  
  projects = {}
  
  project = kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    image = project.css("div.project-thumbnail a img").attribute("src").value
    description = project.css("p.bbcard_blurb").text
    location = project.css("p.ul.project-meta span.location-name").text
    percent_funded = project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    projects[title.to_sym] = {
      :image_link => image,
      :description => description,
      :location => location,
      :percent_funded => percent_funded
    }
  end
  
  projects
end