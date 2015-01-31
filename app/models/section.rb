class Section < ActiveRecord::Base
  # attr_accessor :heading, :body, :post_id
  belongs_to :post, dependent: :destroy
end
