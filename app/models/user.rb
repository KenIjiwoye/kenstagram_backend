class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :jwt_authenticatable,
  jwt_revocation_strategy: JwtDenylist,
  :authentication_keys => [:username]

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_many :posts
end
