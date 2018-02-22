$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "ar_redis/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ar_redis"
  s.version     = ArRedis::VERSION
  s.authors     = ["Nick Weiland"]
  s.email       = ["nickweiland@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of ArRedis."
  s.description = "Description of ArRedis."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0.beta2"
  s.add_dependency "redis", ">= 3.0.4"

  s.add_development_dependency "sqlite3"
end
