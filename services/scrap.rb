# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class ScrapBBCRecipes
  def initialize(keyword)
    @keyword = keyword
    @list = []
    @url = "https://www.bbcgoodfood.com/search/recipes?query="
  end

  def call
    doc = Nokogiri::HTML(open(@url + @keyword))
    doc.search('article').each do |element|
      title = element.search('.teaser-item__title a').text.strip
      description = element.search('.teaser-item__text-content').text.strip
      prep_time = element.search('.hours').text.strip
      difficulty = element.search('.teaser-item__info-item--skill-level').text.strip
      @list << [title, description, prep_time, difficulty]
    end
    @list[0..4]
  end
end
