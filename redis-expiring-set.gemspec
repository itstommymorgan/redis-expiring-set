# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redis-expiring-set/version"

Gem::Specification.new do |s|
  s.name        = "redis-expiring-set"
  s.version     = Redis::ExpiringSet::VERSION
  s.authors     = ["Tommy Morgan"]
  s.email       = ["tommy.morgan@gmail.com"]
  s.homepage    = "http://github.com/duwanis/redis-expiring-set"
  s.summary     = %q{Add an expiring set to redis.}
  s.description = %q{Add some commands to Redis that make it easy to work with a set of objects that need to expire individually.}

  s.rubyforge_project = "redis-expiring-set"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "redis"
end
