FactoryGirl.define do
	factory :event do
		title "ドックレース"
		category "ペット"
		place "公園"
		address "静岡"
		cost "1000"
		factory :single_event do
			coler "green"
		end
		factory :group_event do
			message "ドックレースを開催します"
			coler "yellow"
			association :owner, factory: :user 
		end
	end
end