# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create!({:email => "guy@gmail.com", :password => "password", :password_confirmation => "password" })

Category.create [{:name => 'Programming'}, {:name => 'Event'}, {:name => 'Travel'}, {:name => 'Music'}, {:name => 'TV'}]

50.times { |i| user.articles.create(:title => '#{BetterLorem.c(10)} - #{i}', :body => BetterLorem.p(5, false, false), :excerpt => BetterLorem.w(60, true, true), :published_at => Date.today)}