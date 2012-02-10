require 'redis-expiring-set'

Redis.send(:include, Redis::ExpiringSetMethods)
