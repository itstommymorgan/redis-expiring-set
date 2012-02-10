# Redis::ExpiringSet

## Purpose

Redis::ExpiringSet provides a very specific but useful data-type to your Redis
environment - a set of objects where each has its own specified expiration time.

Imagine, for example, that you want to keep details on every email that your
system sent out in the last 24 hours. Dump the data into an ExpiringSet with a
24-hour expiration time and let the set manage itself - you'll only ever see
data that is no more than 24 hours old.

## Usage

The commands for Redis::ExpiringSet are designed to closely mirror those Redis
already has in place for working with sets. As of this release the commands are
not a complete copy of what's available for working with sets in Redis, but they
serve to be functional. Example usage:

    require 'redis-expiring-set'

    redis = Redis.new
    expset = Redis::ExpiringSet.new(redis)

    # add "something" to the set "some_set" that expires in 10 seconds
    expset.xadd "some_set", "something", Time.now + 10
    # This does the same thing; pass in a number instead of a Time object and it
    # assumes you mean "expire x seconds from now"
    expset.xadd "some_set", "something", 10

    # Decide you want to remove the item before it expires? OK:
    expset.xrem "some_set", "something"

    # Need to know how big the set is?
    expset.xcard "some_set"

    # Want to actually look at your data?
    expset.xmembers "some_set"

    # By default, expired items are removed any time you go to read values
    # (currently, when you call xcard and xmembers). If you want to clear them
    # manually, though, you can use:
    expset.xclearexpired "some_set"

## Alternate Usage

"Ugh, you mean I have to instantiate some new object and use that to interact
with this new data type?"

Not if you don't want to. There's an optional file you can require which
monkeypatches these methods onto the Redis class so that you can use it without
ever having to touch an instance of Redis::ExpiringSet. Example:

    require 'redis-expiring-set/monkeypatch'

At this point you can use `xadd`, `xrem`, `xcard`, `xmembers`, and
`xclearexpired` just like they were native redis methods. This just isn't the
default functionality because I don't want you to have to monkeypatch Redis for
this if you don't want to.

## Get it

It's a gem named redis-expiring-set. Install it and make it available however
you prefer.

## Performance

Redis::ExpiredSet uses nothing but native Redis functions to manipulate data,
and under the hood we use sorted sets. Expiring items in the set is only done
when it's absolutely necessary, so there should be a minimal number of
unnecessary operations.

BUT, obviously, one of the chief advantages of using Redis is the performance,
so if you notice anything that might make this library any more performant, I'd
be glad to hear about it.

## Contributions

If Redis::ExpiringSet interests you and you think you might want to contribute, hit me up
over Github. You can also just fork it and make some changes, but there's a
better chance that your work won't be duplicated or rendered obsolete if you
check in on the current development status first.

## Development notes

You need Redis installed to do development on Redis::ExpiringSet, and currently the test
suites assume that you're using the default configurations for Redis. That
should probably change, but it probably won't until someone needs it to.

Gem requirements/etc. should be handled by Bundler.

## License
Copyright (C) 2012 by Tommy Morgan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
