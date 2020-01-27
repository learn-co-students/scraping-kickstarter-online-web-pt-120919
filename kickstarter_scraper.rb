require 'nokogiri'

def create_project_hash
	projects = {}

	kickstarter = Nokogiri::HTML(File.read('./fixtures/kickstarter.html'))
	
	kickstarter.css("li.project.grid_4").each do |project|
		title = project.css("h2.bbcard_name strong a").text.to_sym
		projects[title] = {}

		projects[title][:image_link] = project.css("div.project-thumbnail a img").attribute("src").value
		projects[title][:description] = project.css("p.bbcard_blurb").text
		projects[title][:location] = project.css("ul li a span.location-name").text
		projects[title][:percent_funded] = project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
	end
	projects
end