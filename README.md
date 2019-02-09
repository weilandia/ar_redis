# ArRedis

ArRedis allows you to easily create and remove nested, namespaced Redis keys under ActiveRecord objects and classes. The functionality is inspired by [this RailsConf presentation](https://www.youtube.com/watch?v=dH6VYRMRQFw) by Obie Fernandez.  Also, [Nest](https://github.com/soveran/nest) is a similar gem that does not hook into ActiveRecord.

## Installation
Add this line to the Gemfile of an application that uses ActiveRecord:

```ruby
gem 'ar_redis'
```

And then execute:
```bash
$ bundle
```

If you are not using Redis in you application yet, setup the [redis-rb gem](https://github.com/redis/redis-rb).

## Usage

All ActiveRecord models will be provided with the method ```#redis```.

Given:

```ruby
class TestModel < ActiveRecord::Base
end
```

You can now create nested, namespaced Redis keys that have access to all [Redis commands](https://redis.io/commands).

```ruby
>> test_model = TestModel.create
>> #<TestModel:0x007fc08a466890 id: 1>

>> test_model.redis.key
=> "TestModel:1"

>> test_model.redis[:reports]["01/2018"].key
=> "TestModel:1:reports:01/2018"

>> test_model.redis[:reports]["01/2018"].call(:set, { clicks: 12, views: 100 }.to_json)
=> "OK"

>> JSON.parse(test_model.redis[:reports]["01/2018"].call(:get))
=> { clicks: 12, views: 100 }
```

### Configuring your Redis Client
Here's an example of how you can pass a specific Redis client to ArRedis

```ruby
# initializers/redis.rb
$redis = Redis.new(host: "10.0.1.1", port: 6380, db: 15)
ArRedis.redis = $redis
```

## Contributing

Write some code!

1. [Fork](https://help.github.com/articles/fork-a-repo) ArRedis
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your
   branch
5. That's it!

If you're not doing some sort of refactoring, a CHANGELOG entry is appropriate.
Please include them in pull requests adding features or fixing bugs.

Tests
-----

We use rspec for testing.

A simple `bundle exec rspec` will run all the tests. Make sure they pass when
you submit a pull request.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
