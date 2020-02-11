# frozen_string_literal: true

require_relative 'view'
require_relative 'recipe'
require_relative '../services/scrap'
require 'nokogiri'
require 'open-uri'
require 'pry-byebug'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.display_recipes(@cookbook.all)
  end

  def create
    name = @view.ask_for_recipe_name
    description = @view.ask_for_recipe_description
    prep_time = @view.ask_for_recipe_time
    recipe = Recipe.new(name, description, prep_time)
    @cookbook.add_recipe(recipe)
  end

  def import
    keyword = @view.ask_search_keyword
    scrapes = ScrapBBCRecipes.new(keyword).call
    @view.display_scrape(scrapes, keyword)
    selection = scrapes[@view.ask_for_scrape_index - 1]
    recipe = Recipe.new(selection[0], selection[1], selection[2], selection[3])
    @cookbook.add_recipe(recipe)
  end

  def update
    list
    index = @view.ask_for_index
    @cookbook.update_recipe(index)
    puts "------------------------------------"
    list
  end

  def destroy
    list
    index = @view.ask_for_index
    @cookbook.remove_recipe(index)
    puts "------------------------------------"
    list
  end
end
