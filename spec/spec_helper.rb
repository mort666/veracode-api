#we need the actual library file
# require_relative '../lib/veracode'
# For Ruby < 1.9.3, use this instead of require_relative
require(File.expand_path('../../lib/veracode-api', __FILE__))

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

require 'dotenv'

Dotenv.load

Turn.config do |c|
  # :outline  - turn's original case/test outline mode [default]
  c.format  = :outline
  # turn on invoke/execute tracing, enable full backtrace
  c.trace   = true
  # use humanized test names (works only with :outline format)
  c.natural = true
end

#VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/veracode_cassettes'
  c.hook_into :webmock

  c.before_record do |i|
    i.response.headers.delete('Set-Cookie')
    i.response.headers.delete('Authorization')

    u = URI.parse(i.request.uri)
    i.request.uri.sub!(/:\/\/.*#{Regexp.escape(u.host)}/, "://#{u.host}")
  end

  c.register_request_matcher :anonymized_uri do |request_1, request_2|
    (URI(request_1.uri).port == URI(request_2.uri).port && URI(request_1.uri).path == URI(request_2.uri).path)
  end
end
