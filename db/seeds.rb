# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require 'factory_girl_rails'
# Dir[Rails.root.join('spec/support/factories/*.rb')].each {|f| require f }

[Comment, Entry, Event, Relationship, Timeplan, User].each do |t|
	t.delete_all
end

# FactoryGirl.create_list(:user, 50)

50.times do |n|
	User.create(username: "user#{n+1}", email: "user#{n+1}@test.com",
		password: "password", confirmed_at: Time.now)
end
