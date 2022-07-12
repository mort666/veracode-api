require 'xmlsimple'
require 'openssl'
require 'securerandom'

module Veracode
  module API
    class Base
      attr_accessor *Config::VALID_OPTIONS_KEYS

      attr_accessor :account_id

      include HTTParty

      base_uri 'https://analysiscenter.veracode.com'

      VERACODE_REQ_VER = "vcode_request_version_1"

      def initialize(options={})
        attrs = Veracode::API.options.merge(options)
        Config::VALID_OPTIONS_KEYS.each do |key|
          send("#{key}=", options[key])
        end
      end

      def account_id
        if @account_id.nil?
          xml = getXML("/api/5.0/getapplist.do")
          @account_id ||= XmlSimple.xml_in(xml.body)['account_id']
        else
          @account_id
        end
      end

      def postAPI(path, query={}, debug=false)
        options = { :query => query, headers: { "Authorization" => veracode_sign(path, 'POST') } }

        self.class.post(path, options)
      end

      def getXML(path, debug=false)
        self.class.get(path, headers: { "Authorization" => veracode_sign(path) })
      end
    private

      # Somewhat Cludgy Implementation of the Veracode API Signing
      def veracode_sign(url_path, request_method='GET', endpoint_host='analysiscenter.veracode.com')
        request_data = "id=#{veracode_id}&host=#{endpoint_host}&url=#{url_path}&method=#{request_method}"
        nonce = SecureRandom.hex(32)
        timestamp = DateTime.now.strftime('%Q')

        encrypted_nonce = OpenSSL::HMAC.hexdigest("SHA256", veracode_key.scan(/../).map(&:hex).pack("c*"), nonce.scan(/../).map(&:hex).pack("c*"))
        encrypted_timestamp = OpenSSL::HMAC.hexdigest("SHA256", encrypted_nonce.scan(/../).map(&:hex).pack("c*"), timestamp)
        signing_key = OpenSSL::HMAC.hexdigest("SHA256", encrypted_timestamp.scan(/../).map(&:hex).pack("c*"), VERACODE_REQ_VER )
        signature = OpenSSL::HMAC.hexdigest("SHA256", signing_key.scan(/../).map(&:hex).pack("c*"), request_data)

        auth_header = "VERACODE-HMAC-SHA-256 id=#{veracode_id},ts=#{timestamp},nonce=#{nonce},sig=#{signature}"
        return auth_header
      end

    end
  end
end
