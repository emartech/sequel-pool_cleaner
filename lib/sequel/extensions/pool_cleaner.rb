module Sequel
  module PoolCleaner

    class Retry < Error
    end

    # The number of seconds that need to pass since connection checking before terminating
    # and rebuilding the connection when checking it out from the pool.
    # Defaults to 1800 seconds (1 hour).

    attr_accessor :connection_timeout



    def self.extended(pool)
      pool.instance_eval do
        @connection_timestamps ||= {}
        @connection_timeout = 1800
      end

      pool.db.send(:valid_connection_sql)
    end



    private

    def checkin_connection(*)
      connection = super
      @connection_timestamps[connection] = Time.now
      connection
    end



    def acquire(*a)
      begin
        connection = super
        if expired_connection?(connection)
          db.loggers.each { |logger| logger.debug "Throwing away expired connection (been idle for #{@connection_timeout} seconds)" }

          remove_connection_from_pool
          db.disconnect_connection connection

          raise Retry
        end
      rescue Retry
        retry
      end

      connection
    end



    def expired_connection?(connection)
      return false if connection.nil?
      return false unless @connection_timestamps.has_key? connection

      t = sync { @connection_timestamps.delete(connection) }
      Time.now - t > @connection_timeout
    end



    def remove_connection_from_pool
      case pool_type
        when :threaded
          sync { @allocated.delete(Thread.current) }
        else
          db.loggers.each { |logger| logger.error "Unsupported connection pool type: #{pool_type}" }
      end
    end
  end


  Database.register_extension(:pool_cleaner) { |db| db.pool.extend PoolCleaner }

end
