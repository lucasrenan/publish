class Product
  include Mongoid::Document
  include Mongoid::Publish

  attr_reader :before_publish_called, :after_publish_called
  
  field :name

  before_publish do
    @before_publish_called = true
  end

  after_publish do |object|
    @after_publish_called = true
  end
end