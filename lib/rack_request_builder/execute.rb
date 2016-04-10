module RackRequestBuilder
  # RackRequestBuilder::Execute
  module Execute
    # .execute
    #
    # @see https://github.com/ruby/ruby/blob/3e92b635fb5422207b7bbdc924e292e51e21f040/lib/webrick/httprequest.rb
    #
    def execute(http_data)
      io = StringIO.new(http_data)

      req = WEBrick::HTTPRequest.new(
        ServerSoftware: RackRequestBuilder,
        InputBufferSize: 65_536
      )
      req.parse(io)
      env = env(req)

      ::Rack::Request.new(env)
    end

    module_function :execute
  end
end
