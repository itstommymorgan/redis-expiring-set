require 'test_helper'

describe Redis::ExpiringSet do
  describe "newly instantiated" do
    before do
      @redis = Redis.new(:db => 15)
      @expset = Redis::ExpiringSet.new(@redis)
    end

    after do
      clear_test_db
    end

    it "allows things to be added to expiration sets using xadd" do
      assert_equal true, @expset.xadd("some_set", "some_value", Time.now + 10)
    end

    it "allows expiration to set in terms of seconds as well" do
      assert_equal true, @expset.xadd("some_set", "some_value", 60)
    end

    it "allows items to be removed from expiration sets using xrem" do
      assert_equal true, @expset.xadd("some_set", "some_value", 60)
      assert_equal true, @expset.xrem("some_set", "some_value")
    end

    it "allows for all items in an expiration set to be returned by xmembers" do
      assert_equal true, @expset.xadd("some_set", "some_value", 300)
      assert_equal ["some_value"], @expset.xmembers("some_set")
    end

    it "doesn't include any already expired items in xmembers" do
      assert_equal true, @expset.xadd("some_set", "some_value", Time.now - 100)
      assert_equal [], @expset.xmembers("some_set")
    end

    it "allows for a count of items in an expiration set using xcard" do
      assert_equal 0, @expset.xcard("some_set")
      assert_equal true, @expset.xadd("some_set", "some_value", 60)
      assert_equal 1, @expset.xcard("some_set")
    end
  end
end
