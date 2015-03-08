class User < ActiveRecord::Base
  include PublicActivity::Common
  acts_as_taggable

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

  scope :fakers, -> { where(faker: true)}
  scope :desc, -> { order(updated_at: :desc)}

  acts_as_followable
  acts_as_follower

  mount_uploader :avatar, AvatarUploader

  has_one :user_body, dependent: :destroy
  accepts_nested_attributes_for :user_body

  delegate :gender, :male?, :female?, :birth_date, :website, :phone, :weibo, :tqq_weibo, to: :user_body, allow_nil: true, prefix: nil

  after_create :ensure_create_user_body

  def chinese_gender
    return "男" if self.male?
    return "女" if self.female?
  end

  def marking? topic_id
    MarkerTopic.where(topic_id: topic_id, user_id: self.id).exists?
  end

  def keeping? topic_id
    KeeperTopic.where(topic_id: topic_id, user_id: self.id).exists?
  end

  def teachers_ids
    self.teachers.pluck(:recipient_id)
  end

  def recomment_users
    my_owner_ids = UserRelationship.where(recipient_id: self.id).pluck(:owner_id)
    my_owner_s_owner_ids = UserRelationship.where(recipient_id: my_owner_ids).pluck(:owner_id)

    User.where.not(avatar: nil).where(id: (my_owner_s_owner_ids - my_owner_ids).sample(5))
  end

  def read_direct_messages(direct_messages)
    dm_ids = direct_messages.map(&:id)
    DirectMessage.not_read.where(id: dm_ids).update_all(read: true)
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

  private
  def ensure_create_user_body
    self.create_user_body if self.user_body.blank?
  end
end
