FactoryGirl.define do
  factory :comment do
  	body "こんにちは"
  	association :user
  	association :event, factory: :group_event
  end

end
