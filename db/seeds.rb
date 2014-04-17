# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#!!!!!!!!!!!!! 4/17/2014 basic layout made, 'rake db:seed' NOT RUN.
product_list = [
  [ "GXP2200" ],
  [ "GXP2160" ], 
  [ "GXP2140" ], 
  [ "GXP2130" ]
  #...
  ]
  product_list.each do |name|
    Product.create( name: name )
end