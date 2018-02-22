require "ar_redis/base"

module ArRedis
  extend self

  def redis
    return @redis if @redis
    self.redis = Redis.new
    self.redis
  end

  def redis=(server)
    @redis = server
  end
end

binding.pry
