require "forwardable"

require "redis"
require "redis-expiring-set/version"


class Redis
  module ExpiringSetMethods
    def xadd(key, value, expires)
      if expires.is_a? Numeric
        expires = Time.now + expires
      end

      zadd(key, expires.to_f, value)
    end

    def xrem(key, value)
      zrem(key, value)
    end

    def xmembers(key)
      xclearexpired(key)
      zrangebyscore(key, -Float::INFINITY, Float::INFINITY)
    end

    def xclearexpired(key)
      zremrangebyscore key, -Float::INFINITY, Time.now.to_f.to_i
    end

    def xcard(key)
      xclearexpired(key)
      zcard(key)
    end
  end

  class ExpiringSet
    extend Forwardable
    include ExpiringSetMethods

    def_delegators :@redis, :zadd, :zcard, :zrem, :zrangebyscore, :zremrangebyscore

    def initialize(redis)
      @redis = redis
    end
  end
end
