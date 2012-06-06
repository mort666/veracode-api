module Veracode
  class Base
    attr_accessor *Config::VALID_OPTIONS_KEYS
    
    include HTTParty

    base_uri 'https://analysiscenter.veracode.com'
    
    def initialize(options={})
      attrs = Veracode.options.merge(options)
      Config::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def getXML(path, debug=false)
      auth = { :username => @username, :password => @password }

      self.class.get(path, :basic_auth => auth)
    end
    
  end
end