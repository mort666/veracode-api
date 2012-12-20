require 'nori'

require 'rexml/document'

class ::String
  def to_bool
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    return false if self == false || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end

class ::Hash
  def method_missing(name)
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    super.method_missing name
  end
end

class Nori
  class XMLUtilityNode
    def prefixed_attributes
      attributes.inject({}) do |memo, (key, value)|
        memo[prefixed_attribute_name("#{key}")] = value
        memo
      end
    end
  end
end

module Veracode
  class Parser
    def self.parse(xml)
      parser = XML::SAXParser.new()  
      parser.options = {}
      REXML::Document.parse_stream(xml, parser)
      
      parser.stack.length > 0 ? parser.stack.pop.to_hash : {}
      
    end
  end
  
  module XML

    class SAXParser 
      attr_accessor :options
      def stack
        @stack ||= []
      end
      
      def tag_start(name, attrs)
        stack.push Nori::XMLUtilityNode.new(options, name, Hash[*attrs.flatten])
      end

      def tag_end(name)
        if stack.size > 1
          last = stack.pop
          stack.last.add_node last
        end
      end

      def text(string)
        stack.last.add_node(string) unless string.strip.length == 0 || stack.empty?
      end

      # Treat CDATA sections just like text
      alias_method :cdata, :text

      def method_missing(sym, *args)
      end

      def initialize(callback=nil)
      
      end
    end # SAXParser
  end # XML 
end