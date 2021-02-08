class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  #いいね機能
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  #コメント機能
  has_many :book_comments, dependent: :destroy
  #フォロー機能
  has_many :follower, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :follower_users, through: :follower, source: :following
  has_many :following_users, through: :following, source: :follower
  #いいね機能
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
  #フォロー機能
  def following?(other_user)
    following.find_by(follower_id: other_user.id)
  end

  def follow(other_user)
    following.create(follower_id: other_user.id)
  end

  def unfollow(other_user)
    following.find_by(follower_id: other_user.id).destroy
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }

end
