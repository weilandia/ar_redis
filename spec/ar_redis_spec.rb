require "spec_helper"

describe ArRedis do
  describe ".redis" do
    it "allows you to set a specific Redis instance" do
      redis = Redis.new(port: 0, db: 1)
      ArRedis.redis = redis

      expect(redis).to eq(ArRedis.redis)
    end

    it "ignores argument and creates a new Redis instance if argument is not a Redis instance" do
      redis = "not redis"
      ArRedis.redis = redis
      expect(ArRedis.redis).to_not eq(redis)
      expect(ArRedis.redis.is_a?(Redis)).to eq(true)
    end
  end
end
