# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#expectation is that initial user authenticates by facebook
#this results in a user that is not a shareholder
#no way to elevate to shareholder through UI if not a shareholder to start with
#so we use seed.rb to elevate.
my_class = User.find_by_name('Chris Smyth')

if my_class != nil then
  my_class.update_attributes(
     :shareholder => true, :shareholding_percent => 20
  )

  my_class.save
end
