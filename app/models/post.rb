class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy

  def liked? (user)
    !!self.likes.find{ |like| like.user == user.id }
  end 
  

  def post_img
    url_for(image) if image.attached?
  end
end
