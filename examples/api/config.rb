require 'thin'
require 'pry'
require_relative '../../core/core'

migration_files = Dir.glob(File.join(__dir__, '/data/migrations', '**', '*.rb'))
migration_files.each do |file|
	require_relative file
end

models_files = Dir.glob(File.join(__dir__, '/data/models', '**', '*.rb'))
models_files.each do |file|
	require_relative file
end

handler_files = Dir.glob(File.join(__dir__, '/handlers', '**', '*.rb'))
handler_files.each do |file|
	require_relative file
end

require_relative 'routes'

def get_migrations
  migrations = [];
  ObjectSpace.each_object(Class) do |klass|
    if klass.ancestors.include?(::Data::Migration)
      migrations << klass
    end
  end
  migrations
end

def initialize_app(database_config)
  database = ::Data::Initializer.new(database_config)

  database.migrate(get_migrations)

  ::Handle::Base.call do |request:, response:|
    ::Route::Router.route(
      method: request.method,
      path: request.path,
      params: request.params,
      response: response,
      request: request,
      database: database
    )
  end
end