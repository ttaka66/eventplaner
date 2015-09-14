class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :timeplans
	accepts_nested_attributes_for :timeplans, allow_destroy: true
end
