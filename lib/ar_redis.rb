require "ar_redis/railtie"

module ArRedis
  def self.redis
    return @redis if @redis
    self.redis = Redis.new
    self.redis
  end

  def self.redis=(server)
    @redis = server
  end
end
