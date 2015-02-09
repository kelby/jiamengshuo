class User < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessor :login

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :subjects, dependent: :destroy

  # join table
  has_many :applies
  has_many :apply_students, class_name: 'User', through: :applies, foreign_key: :mentor_id
  has_many :applied_mentors,  class_name: 'User', through: :applies, foreign_key: :user_id

  # join table
  has_many :mentor_pending_applies, ->{ pending }, class_name: 'Apply', foreign_key: :mentor_id
  has_many :pending_apply_students, class_name: 'User', through: :mentor_pending_applies, foreign_key: :mentor_id

  # join table
  has_many :marker_topics
  has_many :keeper_topics

  # join tables, for user relationship.
  has_many :teachers, foreign_key: :owner_id
  has_many :students, foreign_key: :owner_id
  has_many :classmates, foreign_key: :owner_id

  acts_as_followable
  acts_as_follower

  mount_uploader :avatar, AvatarUploader

  def marking? topic_id
    MarkerTopic.where(topic_id, self.id).exists? 
  end

  def keeping? topic_id
    KeeperTopic.where(topic_id, self.id).exists? 
  end

  def teachers_ids
    self.teachers.pluck(:recipient_id)
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
end
