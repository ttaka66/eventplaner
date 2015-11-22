FactoryGirl.define do
  factory :timeplan do
  	association :event, factory: :group_event
  	start Time.zone.local(2017, 01, 01, 00, 00, 00)
  	self.end Time.zone.local(2017, 01, 01, 01, 00, 00)
  	factory :timeplan_has_two_attendance do
  		after(:build) do |timeplan|
	  		2.times do
	  			timeplan.entries << build(:entry_attendance_true, timeplan: timeplan)
	  		end
	  	end
  	end
    
  end

end
