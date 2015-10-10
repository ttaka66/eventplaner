class Event < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode
	has_and_belongs_to_many :users
	has_many :timeplans
	has_many :comments
	has_many :users, through: :comments
	accepts_nested_attributes_for :timeplans, allow_destroy: true
end
