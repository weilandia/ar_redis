module ArRedis
  class Base
    attr_reader :key, :redis_client

    def initialize(key)
      @key = key.to_param
      @redis_client = ArRedis.redis
    end

    def [](next_key)
      ArRedis.new("#{key}:#{next_key}", redis_client)
    end

    def destroy
      keys = redis_client.keys("#{self}:*")

      unless keys.blank
        redis_client.del(keys)
      end
    end

    private

    def to_s
      key
    end

    def call(command, *arguments)
      redis_client.call(command, key, *arguments)
    end
  end
end
