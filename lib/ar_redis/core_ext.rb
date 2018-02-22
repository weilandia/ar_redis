ActiveRecord::Base.class_eval do
  def rdb
    ArRedis.new(self.class.name)[id]
  end

  def self.rdb
    ArRedis.new(name)
  end
end
