class Timeplan < ActiveRecord::Base
  include Validators
	validates :start, presence: true
	validates :end, presence: true
	validate :start_sould_be_after_now
	validate :end_sould_be_after_start
  belongs_to :event
  has_many :entries
  has_many :users, through: :entries

  attr_accessor :attend_cnt
  attr_accessor :my_entry

end
