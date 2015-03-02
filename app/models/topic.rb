class Topic < ActiveRecord::Base
  include PublicActivity::Common

  acts_as_taggable
  belongs_to :user
  has_many   :comments, as: :commentable, dependent: :destroy
  has_one    :snippet
  belongs_to :catalog

  enum category: { qi_ta: 0, bai_shi: 1, shou_tu: 2, bai_shi_he_shou_tu: 3 }

  # join tables
  has_many :keeper_topics#, ->{ where related_by: 'stick'}, class_name: 'TopicAndUser'
  has_many :marker_topics#, ->{ where related_by: 'follower'}, class_name: 'TopicAndUser'
  # has_many :keepers#, ->{ where related_by: 'keeper'}, class_name: 'TopicAndUser'

  # has_many :sticked_users, class_name: 'User', through: :sticks
  # has_many :followered_users, class_name: 'User', through: :followers
  # has_many :keepered_users, class_name: 'User', through: :keepers

  validates_presence_of :user_id, :title, :body, :catalog_id

  scope :essences, -> { where(essence: true) }

  searchable do
    text :title, :default_boost => 2
    text :body

    integer :user_id
  end

  # Note: hacking tag_list
  def tag_list_with_string
    tag_list_without_string.to_s
  end
  alias_method_chain :tag_list, :string
end
