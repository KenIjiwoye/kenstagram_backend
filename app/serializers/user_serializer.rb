class UserSerializer
  include JSONAPI::Serializer

  attributes :username, :email, :id
  has_many :posts
end
