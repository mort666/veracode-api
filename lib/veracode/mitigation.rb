require 'nokogiri'
require 'veracode/parser/parser'
require 'veracode/api/mitigation'

module Veracode
  module API
    class Mitigiation < Veracode::API::Base
      GET_MITIGATION_INFO_URI = "/api/getmitigationinfo.do"
      UPDATE_MITIGATION_INFO_URI = "/api/updatemitigationinfo.do"
      
      ACTIONS = ["comment", "fp", "appdesign", "osenv", "netenv", "rejected", "accepted"]
      
      def update_mitigation(build_id, comment, action="comment", flaw_list=[]) 
        if flaw_list.class? == Array
           flaw_id_list = flaw_list.join(",")
         else
           flaw_id_list = flaw_list.to_s
         end
         
         if ACTIONS.include?(action)        
           query = { :build_id => build_id,  :flaw_id_list => flaw_id_list, :action => action, :comment => comment }
          
           xml = postAPI(UPDATE_MITIGATION_INFO_URI, query)
           case xml.code
      	   when 200
      	      clean_xml = xml.body.strip
      	      parsed = Veracode::Parser.parse(clean_xml) 
      	      mitigationinfo = Veracode::Result::MitigationInfo.new(parsed)
           else
              xml.error!
           end
         else
           ArgumentError.new("invalid value for action: \"#{self}\"")
         end
      end
      
      def get_mitigation(build_id, flaw_list=[])
         if flaw_list.class? == Array
           flaw_id_list = flaw_list.join(",")
         else
           flaw_id_list = flaw_list.to_s
         end
         
         query = { :build_id => build_id,  :flaw_id_list => flaw_id_list }
          
         xml = postAPI(GET_MITIGATION_INFO_URI, query)
         case xml.code
    	   when 200
    	      clean_xml = xml.body.strip
    	      parsed = Veracode::Parser.parse(clean_xml) 
    	      mitigationinfo = Veracode::Result::MitigationInfo.new(parsed)
         else
            xml.error!
         end
      end
    end
  end
end
