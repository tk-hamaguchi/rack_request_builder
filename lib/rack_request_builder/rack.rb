module RackRequestBuilder
  # RackRequestBuilder::Rack
  #
  # @see https://github.com/rack/rack/blob/95172a60fe5c2a3850163fc75e0981fe440c064e/lib/rack.rb
  #
  module Rack
    RACK_VERSION      = ::Rack::RACK_VERSION
    VERSION           = ::Rack::VERSION
    RACK_INPUT        = ::Rack::RACK_INPUT
    RACK_ERRORS       = ::Rack::RACK_ERRORS
    RACK_MULTITHREAD  = ::Rack::RACK_MULTITHREAD
    RACK_MULTIPROCESS = ::Rack::RACK_MULTIPROCESS
    RACK_RUNONCE      = ::Rack::RACK_RUNONCE
    RACK_URL_SCHEME   = ::Rack::RACK_URL_SCHEME
    HTTPS             = ::Rack::HTTPS
    RACK_IS_HIJACK    = ::Rack::RACK_IS_HIJACK
    RACK_HIJACK       = ::Rack::RACK_HIJACK
    RACK_HIJACK_IO    = ::Rack::RACK_HIJACK_IO
    QUERY_STRING      = ::Rack::QUERY_STRING
    HTTP_VERSION      = ::Rack::HTTP_VERSION
    SERVER_PROTOCOL   = ::Rack::SERVER_PROTOCOL
    PATH_INFO         = ::Rack::PATH_INFO
    SCRIPT_NAME       = ::Rack::SCRIPT_NAME
    REQUEST_PATH      = ::Rack::REQUEST_PATH

    # #env
    # @see https://github.com/rack/rack/blob/95172a60fe5c2a3850163fc75e0981fe440c064e/lib/rack/handler/webrick.rb
    #
    def env(req)
      env = req.meta_vars
      env.delete_if { |k, v| v.nil? }

      rack_input = StringIO.new(req.body.to_s)
      rack_input.set_encoding(Encoding::BINARY)

      env.update(
        RACK_VERSION      => Rack::VERSION,
        RACK_INPUT        => rack_input,
        RACK_ERRORS       => $stderr,
        RACK_MULTITHREAD  => true,
        RACK_MULTIPROCESS => false,
        RACK_RUNONCE      => false,
        RACK_URL_SCHEME   => ["yes", "on", "1"].include?(env[HTTPS]) ? "https" : "http",
        RACK_IS_HIJACK    => true,
        RACK_HIJACK       => lambda { raise NotImplementedError, "only partial hijack is supported."},
        RACK_HIJACK_IO    => nil
      )

      env[HTTP_VERSION] ||= env[SERVER_PROTOCOL]
      env[QUERY_STRING] ||= ""
      unless env[PATH_INFO] == ""
        path, n = req.request_uri.path, env[SCRIPT_NAME].length
        env[PATH_INFO] = path[n, path.length-n]
      end
      env[REQUEST_PATH] ||= [env[SCRIPT_NAME], env[PATH_INFO]].join

      env
    end

    module_function :env
  end
end

