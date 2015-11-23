FactoryGirl.define do
  factory :entry do
  	association :user
  	attendance false
  		factory :entry_attendance_true do
  			attendance true
  		end
  end

end