module Data
  class Conn
    def initialize(connection)
      @connection = connection
    end

    def table(key)
      @connection[key.to_sym]
    end 

    def create_table(name, &block)
      @connection.create_table name.to_sym do
        instance_eval(&block)
      end
    end

    def alter_table(name, &block)
      @connection.alter_table name.to_sym do
        instance_eval(&block)
      end
    end

    def migrate_table(name, &block)
      return if @connection.table_exists?(name)

      create_table(name, &block)
    end
  end
end