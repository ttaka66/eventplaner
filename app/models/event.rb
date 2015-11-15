class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :owner, class_name: 'User'
	has_many :timeplans
	has_many :comments
	has_many :users, through: :comments
	accepts_nested_attributes_for :timeplans, allow_destroy: true
end
