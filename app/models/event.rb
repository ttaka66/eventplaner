class Event < ActiveRecord::Base
	include Validators
	validates :title, presence: true, length:{ maximum: 50}
	validates :color, presence: true
	validates :start, presence: { if: 'color == "green"'}
	validate :start_sould_be_after_now
	validates :end, presence: { if: 'color == "green"'}
	validate :end_sould_be_after_start
	has_and_belongs_to_many :users
	belongs_to :owner, class_name: 'User'
	has_many :timeplans
	has_many :comments
	# has_many :users, through: :comments
	accepts_nested_attributes_for :timeplans, allow_destroy: true

	def destroy_timeplans_and_entries
		timeplans.each do |tp|
          tp.entries.destroy_all
          tp.destroy
        end
	end
end
