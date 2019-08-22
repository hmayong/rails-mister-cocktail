# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Creating ingredients...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
json_file = open(url).read
ingredients = JSON.parse(json_file)["drinks"]

ingredients.each do |ingredient|
  new_ingredient = [{name: ingredient["strIngredient1"]}]
  Ingredient.create!(new_ingredient)
end

puts 'Creating Cocktail'

5.times do |c|
  cocktail = Cocktail.create!([{name: Faker::Dessert.flavor}])
end

puts 'Creating Dose'

Cocktail.all.each do |cocktail|
  Dose.create!(
    {
      description: Faker::Dessert.variety,
      cocktail_id: cocktail.id,
      ingredient_id: Ingredient.all.sample.id
    }
  )
end

puts 'Finished!'
