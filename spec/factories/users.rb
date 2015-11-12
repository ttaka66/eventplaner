FactoryGirl.define do
	factory :user do
		username "Johney"
		sequence(:email) { |n| "johney#{n}@test.com"}
		password "password"
    password_confirmation "password"
	end
end