class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

end

# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
end

