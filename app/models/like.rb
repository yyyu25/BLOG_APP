class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }
end

class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
end

class User < ApplicationRecord
  has_many :likes, dependent: :destroy
end
