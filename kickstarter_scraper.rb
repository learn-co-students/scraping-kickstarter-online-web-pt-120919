# require libraries/modules here
require "nokogiri"
require "pry"

=begin 
  Scraping notes 
  
  Instance: <li class="project grid_4"> 
  title: <h2 class="bbcard_name"> strong a (project.css("h2.bbcard_name strong a").text)
  image_link: div class="project-thumbnail" <img alt="Photo-little" class="projectphoto-little"> project.css("div.project-thumbnail a img").attribute("src").value
  description: <p class="bbcard_blurb> project.css("p.bbcard_blurb").text
  location: <ul class="project-meta"> a data-location project.css("ul.project-meta").text
  percent_funded: <li class="first funded"> project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
=end

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html') 
  
  kickstarter = Nokogiri::HTML(html)
  projects = {} 
  
  kickstarter.css("li.project.grid_4").each do |project| 
    title = project.css("h2.bbcard_name strong a").text 
    
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    } 
  end
  projects
end

create_project_hash


