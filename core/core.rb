require 'rack'
require 'json'
require 'sequel'

core_files = Dir.glob(File.join(__dir__, '/', '**', '*.rb'))
core_files.each do |file|
	require_relative file
end