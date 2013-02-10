$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rakeleak/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rakeleak"
  s.version     = Rakeleak::VERSION
  s.authors     = ["Roman Parykin"]
  s.email       = ["hey@donderom.org"]
  s.homepage    = "https://github.com/donderom/rakeleak"
  s.licenses    = ["MIT"]
  s.summary     = "Run any Rake task from your browser with Rakeleak"
  s.description = "Rakeleak is a Rails engine that helps you run any Rake task from browser"

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "rake"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
