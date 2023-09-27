module Data
  class Initializer
    def initialize(config)
      @config = config
    end

    def migrate(migrations)
      perform do |database|
        ::Data::Migrator.new(
          database,
          migrations
        ).call
      end
    end

    def perform
      conn = ::Data::Connection.start(@config)
      
      begin
        yield(conn) if block_given?
      ensure
        ::Data::Connection.close
      end
    end
  end
end