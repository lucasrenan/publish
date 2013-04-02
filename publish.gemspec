$:.push File.expand_path("../lib", __FILE__)
require "mongoid/publish/version"

Gem::Specification.new do |gem|

  gem.name          = "publish"
  gem.authors       = ["Lucas Renan", "Tiago Rafael Godinho", "Marco Singer"]
  gem.email         = ["contato@lucasrenan.com", "tiagogodinho3@gmail.com", "markaum@gmail.com"]
  gem.description   = %q{Adds the functionality to publish/unpublish mongoid docs}
  gem.summary       = %q{Adds the functionality to publish/unpublish mongoid docs}
  gem.homepage      = "https://github.com/lucasrenan/publish"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.version       = Mongoid::Publish::VERSION
  gem.platform      = Gem::Platform::RUBY


  gem.add_dependency "mongoid", ">= 3.1.0"

  gem.add_development_dependency "rails",              ">= 3.2.0"
  gem.add_development_dependency "rake",               "~> 10.0"
  gem.add_development_dependency "simplecov",          "~> 0.7.0"
  gem.add_development_dependency "timecop",            "~> 0.6.1"
end