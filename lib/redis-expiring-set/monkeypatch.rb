require 'redis-expiring-set'

class Redis
  include Redis::ExpiringSetMethods
end
