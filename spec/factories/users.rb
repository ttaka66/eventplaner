FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "user#{n}"}
		sequence(:email) { |n| "user#{n}@test.com"}
		password "password"
		confirmed_at Time.now
	end
end