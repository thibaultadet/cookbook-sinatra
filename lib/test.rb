require 'nokogiri'
require 'open-uri'
require 'pry-byebug'

list = []
ingredient = "strawberry"
# url = 'lib/strawberry.html'
url = "https://www.bbcgoodfood.com/search/recipes?query=" + ingredient
doc = Nokogiri::HTML(open(url))
# binding.pry
doc.search('article').each do |element|
  title = element.search('.teaser-item__title a').text.strip
  description = element.search('.teaser-item__text-content').text.strip
  list << [title, description]
end
p list[0..4]
