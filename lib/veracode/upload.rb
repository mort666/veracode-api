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
          xml.body
        else
          xml.error!
        end
      end
    end 
  end
end