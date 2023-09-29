require_relative 'config'

class Application
  def self.call
    initialize_app(database_config)
  end

  def self.database_config
    {
      adapter: '',
      user: '',
      password: '',
      host: 'localhost',
      port: 5432,
      database: 'postgres'
    }
  end
end

class Server
  def start(options)
    app = Application.call
    
    @current = Rack::Handler::Thin.run(app, **options)
  end

  def stop
    @current.stop
  end
end

Server.new.start(Port: 3030)