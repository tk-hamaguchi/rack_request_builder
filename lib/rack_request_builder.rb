require 'stringio'
require 'webrick'
require 'rack'
require 'rack_request_builder/version'
require 'rack_request_builder/rack'
require 'rack_request_builder/execute'

# RackRequestBuilder
module RackRequestBuilder
  include Rack
  module_function :env

  include Execute
  module_function :execute
end
