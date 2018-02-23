$:.push File.expand_path("lib", __dir__)

require "ar_redis/version"

Gem::Specification.new do |spec|
  spec.name        = "ar_redis"
  spec.version     = ArRedis::VERSION
  spec.authors     = ["Nick Weiland"]
  spec.email       = ["nickweiland@gmail.com"]
  spec.homepage    = "https://github.com/weilandia/ar_redis"
  spec.summary     = %q{ActiveRecord keys for Redis.}
  spec.description = %q{Adds out-of-the-box namespaced and nested Redis keys for ActiveRecord objects.}
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "activerecord", ">= 3.2"
  spec.add_dependency "redis", ">= 3.0.4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
