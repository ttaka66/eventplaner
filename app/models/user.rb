class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :created_events, class_name: 'Event', foreign_key: :owner_id

  has_and_belongs_to_many :events
  has_many :entries
  has_many :timeplans, through: :entries

  has_many :comments
  has_many :events, through: :comments
end
