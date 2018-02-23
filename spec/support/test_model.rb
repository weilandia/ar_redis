require "active_record"

class CreateAllTables < ActiveRecord::Migration[5.0]
  def self.recreate_table(name, *args, &block)
    execute "drop table if exists #{name}"

    create_table(name, *args) do |t|
      t.string :name
    end
  end

  def self.up
    ActiveRecord::Base.establish_connection({ adapter: "sqlite3", database: "/tmp/ar_redis.db" })
    recreate_table(:test_models)
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up

class TestModel < ActiveRecord::Base
end
