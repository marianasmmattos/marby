module Data
  class Migrator
    def initialize(connection, migrations)
      @connection = connection
      @migrations = migrations
    end

    def call
      @migrations.each do |migration_class|
        migration_class.new(@connection).up
      end
    end

    private

    def current_version
      @connection.version
    end
  end
end