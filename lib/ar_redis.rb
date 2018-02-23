require "redis"
require "active_support"
require "ar_redis/version"
require "ar_redis/base"
require "ar_redis/active_record_ext"

module ArRedis
  extend self

  def redis
    return @redis if @redis
    self.redis = Redis.new
    self.redis
  end

  def redis=(server)
    if server.is_a?(Redis)
      @redis = server
    end
  end
end
