# Sequel::PoolCleaner

Checks Sequel connection pool for "dead" connections and removes them.

## Installation

Add this line to your application's Gemfile:

    $ gem 'sequel-pool_cleaner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-pool_cleaner

## Usage

    $ require 'sequel-pool_cleaner'
    $
    $ db = Sequel.connect '<CONNECTION STRING>'
    $ db.extension :pool_cleaner

# To set custom check interval
The default check interval is 1800 seconds ()

    $ db.pool.connection_timeout = <CUSTOM CHECK INTERVAL>

## Contributing

1. Fork it ( https://github.com/emartech/sequel-pool_cleaner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
