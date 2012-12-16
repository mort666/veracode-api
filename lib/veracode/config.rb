module Veracode
  module API
    module Config
      VALID_OPTIONS_KEYS = [
            :username,
            :password].freeze
          
      attr_accessor *VALID_OPTIONS_KEYS

      def configure
        yield self
      end

      # Create a hash of options and their values
      def options
        options = {}
        VALID_OPTIONS_KEYS.each{|k| options[k] = send(k) }
        options
      end
    end
  end
end