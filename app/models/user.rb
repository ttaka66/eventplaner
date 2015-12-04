class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true

  has_many :created_events, class_name: 'Event', foreign_key: :owner_id

  has_and_belongs_to_many :events
  has_many :entries
  has_many :timeplans, through: :entries

  has_many :comments
  has_many :active_relationships, class_name:  "Relationship",
    foreign_key: "own_id", dependent: :destroy
  has_many :friends, through: :active_relationships, source: :friend

end
