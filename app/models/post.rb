class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_one_attached :image

  def post_img
    url_for(image) if image.attached?
  end
end
