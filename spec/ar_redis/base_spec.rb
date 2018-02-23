require "spec_helper"

describe ArRedis::Base do
  before do
    ArRedis.redis = Redis.new(db: 15)
    ArRedis.redis.flushdb
  end

  let(:test_model) { TestModel.create }

  describe ".initialize" do
    it "sets the attr_reader #key" do
      key = "new_key"
      obj = ArRedis::Base.new(key)

      expect(obj.key).to eq(key)
    end

    it "sets the attr_reader #redis_client" do
      key = "new_key"
      obj = ArRedis::Base.new(key)

      expect(obj.redis_client).to eq(ArRedis.redis)
    end
  end

  describe "#[]" do
    it "returns an instance of ArRedis::Base with progressively nested keys" do
      base_key = test_model.redis
      expect(base_key.key).to eq("TestModel:#{test_model.id}")

      first_nest = base_key[:reports]
      expect(first_nest.key).to eq("TestModel:#{test_model.id}:reports")
      expect(first_nest.class).to eq(ArRedis::Base)

      second_nest = first_nest[Time.now.year]
      expect(second_nest.key).to eq("TestModel:#{test_model.id}:reports:#{Time.now.year}")
      expect(second_nest.class).to eq(ArRedis::Base)
    end
  end

  describe "#call" do
    it "provides an api for reaching the commands included in Redis" do
      redis_client = test_model.redis.redis_client

      test_model.redis.call(:set, "1")
      expect(redis_client.call(:get, test_model.redis.key)).to eq("1")
      expect(test_model.redis.call(:get)).to eq("1")
    end
  end

  describe "#delete_all" do
    it "removes all redis keys under the given namespace" do
      key_to_delete = test_model.redis[:delete_me]
      key_to_keep = test_model.redis[:keep_me]

      key_to_delete.call(:set, 1)
      key_to_delete[:nested].call(:set, 1)

      key_to_keep.call(:set, 1)
      key_to_keep[:nested].call(:set, 1)

      expect(key_to_delete.delete_all).to eq(2)

      expect(key_to_delete.call(:get)).to eq(nil)
      expect(key_to_delete[:nested].call(:get)).to eq(nil)

      expect(key_to_keep.call(:get)).to eq("1")
      expect(key_to_keep[:nested].call(:get)).to eq("1")
    end
  end
end
