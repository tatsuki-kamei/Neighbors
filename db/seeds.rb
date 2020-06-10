# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

rice = Category.create(:name=>"rice")
# rice_1 = rice.children.create(:name=>"bowl")
# rice_2 = rice.children.create(:name=>"plate")
# rice_3 = rice.children.create(:name=>"sushi")
# rice_4 = rice.children.create(:name=>"other")

meat = Category.create(:name=>"meat")
# meat_1 = meat.children.create(:name=>"steak")
# meat_2 = meat.children.create(:name=>"humbuger steak")
# meat_3 = meat.children.create(:name=>"chicken")
# meat_4 = meat.children.create(:name=>"other")

soup = Category.create(:name=>"soup")
# soup_1 = soup.children.create(:name=>"ra-men")
# soup_2 = soup.children.create(:name=>"soup pasta")
# soup_3 = soup.children.create(:name=>"consomme")

others = Category.create(:name=>"others")

categories = Category.create(:name=>"all")

