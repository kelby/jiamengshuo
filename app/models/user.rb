class User < ActiveRecord::Base
  attr_accessor :login

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, dependent: :destroy

  # join tables
  has_many :sticks, ->{ where related_by: 'stick'}, class_name: 'TopicAndUser'
  has_many :followers, ->{ where related_by: 'follower'}, class_name: 'TopicAndUser'
  has_many :keepers, ->{ where related_by: 'keeper'}, class_name: 'TopicAndUser'

  has_many :stick_topics, class_name: 'Topic', through: :sticks
  has_many :follower_topics, class_name: 'Topic', through: :followers
  has_many :keeper_topics, class_name: 'Topic', through: :keepers

  def sticking? topic
    self.stick_topics.exists? topic.id
  end

  def followering? topic
    self.follower_topics.exists? topic.id
  end

  def keepering? topic
    self.keeper_topics.exists? topic.id
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
