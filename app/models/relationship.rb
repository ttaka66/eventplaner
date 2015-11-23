class Relationship < ActiveRecord::Base
	belongs_to :own, class_name: "User"
	belongs_to :friend, class_name: "User"
end
