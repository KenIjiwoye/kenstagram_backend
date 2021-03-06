class PostSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :caption, :post_img, :likes

  belongs_to :user

  def image
    return rails_blob_url(object.image) if object.image.attached?
  end
  # def image
  #   rails_blob_path(object.image, disposition: "attachment", only_path: true) if object.image.attached?
  # end
end
