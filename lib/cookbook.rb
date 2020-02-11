require 'csv'
require 'pry-byebug'
require_relative 'recipe'

class Cookbook
  attr_accessor :csv_file
  def initialize(csv_file_path)
    @csv_file = csv_file_path
    @csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    @recipes = []
    load_recipes
  end

  def load_recipes
    CSV.foreach(@csv_file) do |row|
      prep_time = row[2] || "NA"
      difficulty = row[3] || "NA"
      condition = row[4] == "true"
      @recipes << Recipe.new(row[0], row[1], prep_time, difficulty, condition)
    end
  end

  def store_recipes
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    store_recipes
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    store_recipes
  end

  def update_recipe(index)
    @recipes[index].mark_as_done
    store_recipes
  end
end
