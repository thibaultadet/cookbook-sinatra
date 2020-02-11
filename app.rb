# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'services/scrap'
require_relative 'lib/controller'
require_relative 'lib/cookbook'
require_relative 'lib/recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

csv_file   = File.join(__dir__, 'lib/recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all.map do |recipe|
    status = recipe.done?
    [status, recipe.name, recipe.prep_time, recipe.difficulty, recipe.description]
  end
  erb :index
end

get '/new' do
  erb :new
end

post '/add-recipe' do
  recipe = Recipe.new(params[:name],
                      params[:description],
                      params[:prep_time],
                      params[:difficulty])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/delete/:id' do
  index = params[:id].to_i
  cookbook.remove_recipe(index)
  redirect '/'
end

get '/import' do
  erb :import
end

post '/import-recipe' do
  @scrapes = ScrapBBCRecipes.new(params[:ingredient]).call
  erb :import_recipe
end

get '/import/:id' do
  recipe = Recipe.new(params[:name],
                      params[:description],
                      params[:prep_time],
                      params[:difficulty])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/markasdone/:id' do
  index = params[:id].to_i
  cookbook.update_recipe(index)
  redirect '/'
end
