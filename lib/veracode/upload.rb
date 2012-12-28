require 'nokogiri'
require 'veracode/parser/parser'
require 'veracode/api/upload'

module Veracode
  module API
    class Upload < Veracode::API::Base
      CREATE_APP_URI = "/api/4.0/createapp.do"
      DELETE_APP_URI = "/api/4.0/deleteapp.do"
      GET_VENDOR_LIST_URI = "/api/4.0/getvendorlist.do"
      CREATE_BUILD_URI = "/api/4.0/createbuild.do"
      DELETE_BUILD_URI = "/api/4.0/deletebuild.do"
      UPLOAD_FILE_URI = "/api/4.0/uploadfile.do"
      REMOVE_FILE_URI = "/api/4.0/removefile.do"
      GET_FILE_LIST_URI = "/api/4.0/getfilelist.do"
      GET_APP_LIST_URI = "/api/4.0/getapplist.do"
      GET_APP_INFO_URI = "/api/4.0/getappinfo.do"
      GET_BUILD_LIST_URI = "/api/4.0/getbuildlist.do"
      GET_BUILD_INFO_URI = "/api/4.0/getbuildinfo.do"
      BEGIN_PRESCAN_URI = "/api/4.0/beginprescan.do"
      GET_PRESCAN_RESULTS_URI = "/api/4.0/getprescanresults.do"
      BEGIN_SCAN_URI = "/api/4.0/beginscan.do"
    
      def get_application_list
        xml = getXML(GET_APP_LIST_URI)
    	  case xml.code
  	    when 200
          clean_xml = xml.body.strip
  	      parsed = Veracode::Parser.parse(clean_xml) 
  	      apps = Veracode::Upload::AppList.new(parsed.applist)
        else
          xml.error!
        end
      end
      
      def get_build_list(app_id)
        xml = getXML(GET_BUILD_LIST_URI + "?app_id=" + app_id)
        case xml.code
  	    when 200
          clean_xml = xml.body.strip
  	      parsed = Veracode::Parser.parse(clean_xml) 
  	      appinfo = Veracode::Upload::BuildList.new(parsed.buildlist)
        else
          xml.error!
        end
      end
      
      def get_build_info(app_id, build_id=nil) 
        url = GET_BUILD_INFO_URI + "?app_id=" + app_id
        url += "&build_id=#{build_id}" if !build_id.nil? 
        
        xml = getXML(url)
        case xml.code
  	    when 200
          clean_xml = xml.body.strip
  	      parsed = Veracode::Parser.parse(clean_xml) 
  	      builds = Veracode::Upload::BuildInfo.new(parsed.buildinfo)
        else
          xml.error!
        end
      end
      
      def get_application_info(app_id)
        xml = getXML(GET_APP_INFO_URI + "?app_id=" + app_id)
        case xml.code
  	    when 200
          clean_xml = xml.body.strip
  	      parsed = Veracode::Parser.parse(clean_xml) 
  	      appinfo = Veracode::Upload::ApplicationInfo.new(parsed.appinfo)
        else
          xml.error!
        end
      end
    end 
  end
end