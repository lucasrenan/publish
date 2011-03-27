class Post
  include Mongoid::Document
  include Mongoid::Publish
  
  field :title
  field :text
end
