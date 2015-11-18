class Timeplan < ActiveRecord::Base
	validates :start, presence: true
	validates :end, presence: true
	validate :start_sould_be_after_now
	validate :end_sould_be_after_start
  belongs_to :event
  has_many :entries
  has_many :users, through: :entries

  attr_accessor :attend_cnt
  attr_accessor :my_entry

  private

  def start_sould_be_after_now
  	return unless start
  	if Time.zone.now >= start
  		errors.add(:start, 'は現在時間よりも後に設定してください')
  	end
  end

  def end_sould_be_after_start
  	return unless start && self.end
  	if start >= self.end
  		errors.add(:end, 'は開始時間よりも後に設定してください')
  	end
  end

end
