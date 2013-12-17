# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mongoid/publish/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Lucas Renan", "Tiago Rafael Godinho", "Marco Singer"]
  gem.email         = ["contato@lucasrenan.com", "tiagogodinho3@gmail.com", "markaum@gmail.com"]
  gem.description   = %q{Adds the functionality to publish/unpublish mongoid docs}
  gem.summary       = %q{Adds the functionality to publish/unpublish mongoid docs}
  gem.homepage      = "https://github.com/lucasrenan/publish"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "publish"
  gem.require_paths = ["lib"]
  gem.version       = Mongoid::Publish::VERSION
  gem.license       = "MIT"

  gem.add_dependency "mongoid", ">= 3.1.0"

  gem.add_development_dependency "rails",              "~> 4.0.0"
  gem.add_development_dependency "rake",               "~> 10.1.0"
  gem.add_development_dependency "simplecov",          "~> 0.8.0"
  gem.add_development_dependency "timecop",            "~> 0.7.0"
end
