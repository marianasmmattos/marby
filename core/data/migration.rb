module Data
  class Migration
    def initialize(connection)
      @database = connection
    end

    attr_reader :database

    def up
    end
  end
end