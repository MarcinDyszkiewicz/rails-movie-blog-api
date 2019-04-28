class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  #relations
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :ratings
end
