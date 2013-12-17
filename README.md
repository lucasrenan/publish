# Publish [![Build Status](https://secure.travis-ci.org/lucasrenan/publish.png?branch=master)](http://travis-ci.org/lucasrenan/publish) [![Build Status](https://gemnasium.com/lucasrenan/publish.png)](http://gemnasium.com/lucasrenan/publish) [![Code Climate](https://codeclimate.com/github/lucasrenan/publish.png)](https://codeclimate.com/github/lucasrenan/publish) [![Coverage Status](https://coveralls.io/repos/lucasrenan/publish/badge.png?branch=master)](https://coveralls.io/r/lucasrenan/publish)


Publish is a gem that adds the common functionality to publish (or set as draft) a document using Mongoid.

## Installation

Add to Gemfile

``` ruby
gem "publish", "~> 0.4.0"
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

Post.published.count  # 0

p = Post.new
p.published?    # false
p.published_at  # nil

p.publish! # p.published = true

p.published?    # true

Post.published.count  # 1

p.publication_status # Time.now or 'draft'
```

Filtering

``` ruby
Post.published # scope - where(:published => true, :published_at.lte => Time.now)

Post.list(false) # scope - criteria.published
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request