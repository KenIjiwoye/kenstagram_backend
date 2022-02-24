class PostSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :caption, :image

  belongs_to :user

  def image
    if object.image.attached?
      {
        url: rails_blob_url(object.image)
      }
    end
  end
end
