class Timeplan < ActiveRecord::Base
  belongs_to :event
  has_many :entries
  has_many :users, through: :entries
end
