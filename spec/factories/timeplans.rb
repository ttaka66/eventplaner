FactoryGirl.define do
  factory :timeplan do
  	association :event, factory: :group_event
  	sequence(:start) { |n| n.days.since }
  	sequence(:end) { |n| (n.days + 1.hours).since }
  	factory :timeplan_has_two_attendance do
  		after(:build) do |timeplan|
	  		2.times do
	  			timeplan.entries << build(:entry, timeplan: timeplan)
	  		end
	  	end
  	end
    
  end

end
