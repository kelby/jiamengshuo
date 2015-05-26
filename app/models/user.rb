class User < ActiveRecord::Base
  include PublicActivity::Common
  acts_as_taggable

  attr_accessor :login

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false }
  
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:weibo, :qq_connect]

  has_many :topics, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :snippets, dependent: :destroy

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

  has_many :liker_comments, foreign_key: :liker_id, dependent: :destroy

  scope :fakers, -> { where(faker: true)}
  scope :desc, -> { order(updated_at: :desc)}

  acts_as_followable
  acts_as_follower

  mount_uploader :avatar, AvatarUploader

  has_one :user_body, dependent: :destroy
  accepts_nested_attributes_for :user_body

  delegate :gender, :male?, :female?, :birth_date, :website, :phone, :weibo, :qq, :location, to: :user_body, allow_nil: true, prefix: nil

  after_create :ensure_create_user_body

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    self.password = Devise.friendly_token[0,20]
    self.username = omniauth['info']['nickname']
    self.avatar = omniauth.info.image # assuming the user model has an image
    # raw_info = omniauth['extra']['raw_info']

    # unless raw_info['avatar_large'].blank? || is_default_avatar?(raw_info['avatar_large'])
      # self.remote_avatar_url = raw_info['avatar_large']
    # end

    # self.user_profile ||= UserProfile.new
    # user_profile.location ||= omniauth["info"]["location"]
    # user_profile.description ||= raw_info['description']
    # user_profile.gender ||=  raw_info['gender'] == 'm' ? '男' : '女'
    # user_profile.website ||= raw_info['url']

    authentications.build(
      :provider => omniauth['provider'],
      :uid => omniauth['uid'],
      :access_token => omniauth['credentials']['token'],
      :expires_at => omniauth['credentials']['expires_at'])
  end

  def email_required?  
    (authentications.empty? || !email.blank?) && super  
  end  

  def chinese_gender
    return "男" if self.male?
    return "女" if self.female?
  end

  def marking? topic_id
    MarkerTopic.where(topic_id: topic_id, user_id: self.id).exists?
  end

  def liking_it? comment_id
    LikerComment.where(comment_id: comment_id, liker_id: self.id).exists?
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
    @login || self.email #|| self.username
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:email].nil?
        where(conditions).first
      else
        where(email: conditions[:email]).first
      end
    end
  end

  private
  def ensure_create_user_body
    self.create_user_body if self.user_body.blank?
  end
end
