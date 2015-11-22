FactoryGirl.define do
	factory :event do
		title "ドックレース"
		category "ペット"
		place "公園"
		address "静岡"
		cost "1000"
		factory :single_event do
			start Time.zone.local(2017, 01, 01, 00, 00, 00)
		  self.end Time.zone.local(2017, 01, 01, 01, 00, 00)
			color "green"
		end
		factory :group_event do
			message "ドックレースを開催します"
			color "yellow"
			association :owner, factory: :user
			factory :event_have_two_plans do
				after(:build) do |event|
					2.times do
						event.timeplans << build(:timeplans, event: event)
					end
				end	
			end
		end
	end
end