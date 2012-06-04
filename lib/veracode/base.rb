require "net/http"
require "net/https"
require "uri"

module Veracode
  class Base
    attr_accessor *Config::VALID_OPTIONS_KEYS
    
    def initialize(options={})
      attrs = Veracode.options.merge(options)
      Config::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def getXML(path, username, password, debug=false)
      url = URI.parse(path)
      req = Net::HTTP::Get.new(url.request_uri)
      req.basic_auth username, password
      
      site = Net::HTTP.new(url.host, url.port)
      site.use_ssl = true
      site.set_debug_output $stderr if debug
      resp = site.start {|http| http.request(req) }
    end
    
  end
end