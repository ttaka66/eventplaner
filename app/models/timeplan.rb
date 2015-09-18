class Timeplan < ActiveRecord::Base
  belongs_to :event
  has_many :entries
  has_many :users, through: :entries

  attr_accessor :attend_cnt
  attr_accessor :my_entry

end
