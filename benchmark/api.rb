require 'benchmark'
require_relative '../examples/api/app'
require 'net/http'

def api_request
  url = URI.parse('http://0.0.0.0:8080/users')

  Net::HTTP.get_response(url)
end

options = {
  Host: '0.0.0.0',
  Port: 8080,
  Daemonize: false,
}

pid = fork do
  server = Server.new.start(options)

  Signal.trap('INT') do
    server.stop
    exit
  end

  sleep
end

n = 100

Benchmark.bm do |x|
  x.report('Api') do
    n.times do
      api_request
    end
  end
end

Process.kill('INT', pid)
Process.wait(pid)

