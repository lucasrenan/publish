# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "publish"
  s.summary = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}
  #s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.1"
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
  s.add_dependency 'mongoid', '~> 2.0.0.rc.8'
  s.add_dependency 'bson_ext', '~> 1.2.4'
end