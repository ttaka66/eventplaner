FactoryGirl.define do
  factory :timeplan do
  	association :event, factory: :group_event
  	start Time.zone.local(2017, 01, 01, 00, 00, 00)
  	self.end Time.zone.local(2017, 01, 01, 01, 00, 00)
    
  end

end
