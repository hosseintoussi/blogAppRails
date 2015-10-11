# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['user', 'banned', 'moderator', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

# Category.create [{:name => 'Programming'}, {:name => 'Event'}, {:name => 'Travel'}, {:name => 'Music'}, {:name => 'TV'}]

# user = User.find_or_create_by({:email => "guy@gmail.com", :password => "password", :password_confirmation => "password" })

# 50.times { |i| user.articles.create(:title => BetterLorem.c(10, true, true), :body => BetterLorem.p(5, false, false),
# :excerpt => BetterLorem.w(60, true, true), :published_at => Date.today)}

