# Publish [![Build Status](https://secure.travis-ci.org/lucasrenan/publish.png?branch=master)](http://travis-ci.org/lucasrenan/publish) [![Build Status](https://gemnasium.com/lucasrenan/publish.png)](http://gemnasium.com/lucasrenan/publish) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/lucasrenan/publish)


Publish is a gem that adds the common functionality to publish (or set as draft) a document using Mongoid.

## Installation

Add to Gemfile

``` ruby
gem "publish", "~> 0.1.0"
```

Then run

``` terminal
bundle install
```

## Getting started


Include Publish Module to your model

``` ruby
class Post
  include Mongoid::Document
  include Mongoid::Publish

  field :title
  field :text
end

Post.published.count  #0

p = Post.new
p.published?    #false
p.published_at  #nil

p.publish! #p.published = true

p.published?    #true

Post.published.count  #1

p.publication_status #Date.today or 'draft'
```

## Callbacks (before_publish and after_publish)

``` ruby
class Product
  include Mongoid::Document
  include Mongoid::Publish

  field :name

  before_publish do
    puts "before publish"
  end

  after_publish
    puts "after publish"
  end
end

product = Product.new
product.publish! #=> before publish after publish
```