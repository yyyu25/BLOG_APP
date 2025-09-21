class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
end

class User < ApplicationRecord
  has_many :posts
  has_many :comments, dependent: :destroy
end
