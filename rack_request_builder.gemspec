# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack_request_builder/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack_request_builder'
  spec.version       = RackRequestBuilder::VERSION
  spec.authors       = ['Takahiro HAMAGUCHI']
  spec.email         = ['tk.hamaguchi@gmail.com']

  spec.summary       = 'Rack::Request builder from HTTP Data'
  spec.description   = 'Rack::Request builder from HTTP Data.'
  spec.homepage      = 'https://github.com/tk-hamaguchi/rack_request_builder'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features)/})
  }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.3.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_runtime_dependency     'rack',    '2.0.0.alpha'
end
