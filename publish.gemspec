$:.push File.expand_path("../lib", __FILE__)
require "mongoid/version"

Gem::Specification.new do |s|
  s.name = "publish"
  s.summary = "Adds the functionality to publish/unpublish"
  s.description = "Adds the functionality to publish/unpublish"
  #s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = Mongoid::Publish::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Lucas Renan", "Marco Singer"]
  s.email = ["contato@lucasrenan.com", "markaum@gmail.com"]
  s.homepage = "https://github.com/lucasrenan/publish"

  s.rubyforge_project = "publish"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  #s.add_dependency 'activesupport', '~> 3.0.5'
  s.add_dependency 'mongoid', '~> 2.0.2'
  s.add_dependency 'bson_ext', '~> 1.3'
end