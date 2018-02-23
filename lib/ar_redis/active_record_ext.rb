ActiveSupport.on_load(:active_record) do
  ::ActiveRecord::Base.class_eval do
    def redis
      ArRedis::Base.new(self.class.name)[id]
    end

    def self.redis
      ArRedis::Base.new(name)
    end
  end
end
