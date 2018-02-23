require "spec_helper"

describe "active_record_ext" do
  describe "ActiveRecord instances" do
    it "defines #redis on ActiveRecord model intances" do
      test_model = TestModel.new

      expect(test_model).to respond_to(:redis)
    end

    describe "#redis" do
      it "returns an instance of ArRedis::Base with the key namespaced to the ActiveRecord instance id" do
        test_model = TestModel.create

        expect(test_model.redis.class).to eq(ArRedis::Base)
        expect(test_model.redis.key).to eq("#{test_model.class}:#{test_model.id}")
      end
    end
  end

  describe "ActiveRecord classed" do
    it "defines .redis on ActiveRecord model classes" do
      expect(TestModel).to respond_to(:redis)
    end

    describe ".redis" do
      it "returns an instance of ArRedis::Base with the key namespaced to the ActiveRecord calss" do
        expect(TestModel.redis.class).to eq(ArRedis::Base)
        expect(TestModel.redis.key).to eq("TestModel")
      end
    end
  end
end
