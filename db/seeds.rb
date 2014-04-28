# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#User.create(name: 'Chris Smyth', shareholder: true, shareholding_percent: 20, created_at: Time.now)
my_class = User.find_by_name('Chris Smyth')

my_class.update_attributes(
   :shareholder => true
)
