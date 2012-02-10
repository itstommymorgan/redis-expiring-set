require 'test/unit'

require 'partial_minispec'

# include the gem
require 'redis-expiring-set'

# Use database 15 for testing, so we don't risk overwriting any data that's
# actually useful
def clear_test_db
  Redis.new(:db => 15).flushdb
end
