class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :follows_following, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :follows_followed, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :follows_following, source: :followed
  has_many :followers, through: :follows_followed, source: :follower

  before_save { 
    self.username = username.downcase
    self.email = email.downcase 
  }
  validates :username, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  has_secure_password
end
