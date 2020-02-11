class View
  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      status = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1} - #{status} #{recipe.name}"
      puts "Time : #{recipe.prep_time}"
      puts "Difficulty : #{recipe.difficulty}"
      puts "Description : #{recipe.description}"
      puts  '------------------------------------'
    end
  end

  def display_scrape(scrapes, keyword)
    puts "Looking for '#{keyword}' recipes on the Internet..."
    scrapes.each_with_index do |scrape, index|
      puts "#{index + 1} - #{scrape[0]} | #{scrape[2]} | #{scrape[3]}"
    end
  end

  def ask_for_scrape_index
    puts "Which recipe would you like to import? (enter index)"
    gets.chomp.to_i
  end

  def ask_for_recipe_name
    puts "What's the name of the recipe?"
    gets.chomp
  end

  def ask_for_recipe_description
    puts "What's the description of the recipe?"
    gets.chomp
  end

  def ask_for_recipe_time
    puts "How long does it take to make the recipe? (in min)"
    gets.chomp + " mins"
  end

  def ask_for_index
    puts "Index?"
    gets.chomp.to_i
  end

  def ask_search_keyword
    puts "What ingredient would you like a recipe for?"
    gets.chomp
  end
end
