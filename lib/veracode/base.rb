require 'xmlsimple'

module Veracode
  module API
    class Base
      attr_accessor *Config::VALID_OPTIONS_KEYS
    
      attr_accessor :account_id
    
      include HTTParty

      base_uri 'https://analysiscenter.veracode.com'
    
      def initialize(options={})
        attrs = Veracode::API.options.merge(options)
        Config::VALID_OPTIONS_KEYS.each do |key|
          send("#{key}=", options[key])
        end
      end
    
      def account_id
        if @account_id.nil?
          xml = getXML("/api/4.0/getapplist.do")
          @account_id ||= XmlSimple.xml_in(xml.body)['account_id']
        else
          @account_id
        end
      end
    
      def getXML(path, debug=false)
        auth = { :username => @username, :password => @password }

        self.class.get(path, :basic_auth => auth)
      end
    end
  end
end