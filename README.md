RackRequestBuilder
========

Build Rack::Request from HTTP Data.  Based on Webrick(from ruby 2.3.0) and Rack(2.0.0.alpha).

For example
--------

```
require 'rack_request_builder'

http_data = <<'EOS'
POST /somepage.php HTTP/1.1
Host: example.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 25

hoge=HOGE&fuga[moke]=MOKE
EOS

req = RackRequestBuilder(http_data)
#=> #<Rack::Request:0x007fd16a3a8138
 @env=
  {"CONTENT_LENGTH"=>"25",
   "CONTENT_TYPE"=>"application/x-www-form-urlencoded",
   "GATEWAY_INTERFACE"=>"CGI/1.1",
   "PATH_INFO"=>"/somepage.php",
   "QUERY_STRING"=>"",
   "REQUEST_METHOD"=>"POST",
   "REQUEST_URI"=>"http://example.com/somepage.php",
   "SCRIPT_NAME"=>"",
   "SERVER_NAME"=>"example.com",
   "SERVER_PORT"=>"80",
   "SERVER_PROTOCOL"=>"HTTP/",
   "SERVER_SOFTWARE"=>#<Module:0x007fd16a3aa550>,
   "HTTP_HOST"=>"example.com",
   "rack.version"=>[1, 3],
   "rack.input"=>#<StringIO:0x007fd16a3a8f98>,
   "rack.errors"=>#<IO:<STDERR>>,
   "rack.multithread"=>true,
   "rack.multiprocess"=>false,
   "rack.run_once"=>false,
   "rack.url_scheme"=>"http",
   "rack.hijack?"=>true,
   "rack.hijack"=>
    #<Proc:0x007fd16a3a8d68>,
   "rack.hijack_io"=>nil,
   "HTTP_VERSION"=>"HTTP/",
   "REQUEST_PATH"=>"/somepage.php"},
 @params=nil>

req.body.read
#=> "hoge=HOGE&fuga[moke]=MOKE"

req.content_type
#=> "application/x-www-form-urlencoded"

req.host
#=> "example.com"

req.params
#=> {"hoge" => "HOGE", "fuga" => {"moke" => "MOKE"}}

req.path
#=> "/somepage.php"

req.post?
#=> true

req.scheme
#=> "http"

req.url
#=> "http://example.com/somepage.php"
```

Installation
--------

Add this line to your application's Gemfile:

```ruby
gem 'rack_request_builder', github: 'tk-hamaguchi/rack_request_builder'
```

And then execute:

    $ bundle

