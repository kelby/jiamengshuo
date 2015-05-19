class Topic < ActiveRecord::Base
  include PublicActivity::Common

  acts_as_taggable
  belongs_to :user
  has_many   :comments, as: :commentable, dependent: :destroy
  has_one    :snippet
  belongs_to :catalog

  enum category: { pi_fa: 1, ding_zhuo: 2, hai_tao: 3 }
  enum mode: {online_shopping: 1, physical_store: 2}
  enum invoice: {not_sure: 0, yes: 1, no: 2}

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
