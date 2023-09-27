module Data
  class Connection
    def self.start(config)
      @db ||= Sequel.connect(**config)
      @database_adapter = ::Data::Conn.new(@db)

      yield(@db) if block_given?

      @database_adapter
    end

    def self.close
      @db.disconnect if @db
      @db = nil
      @database_adapter = nil
    end
  end
end