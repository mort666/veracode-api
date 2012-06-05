require 'nokogiri'
require 'veracode/api/builds'
require 'veracode/api/detailed'

require 'pp'

module Veracode
  class Results < Veracode::Base
    GET_APP_BUILDS_URI = "https://analysiscenter.veracode.com/api/2.0/getappbuilds.do";
  	DETAILED_REPORT_URI = "https://analysiscenter.veracode.com/api/2.0/detailedreport.do";
  	DETAILED_REPORT_PDF_URI = "https://analysiscenter.veracode.com/api/2.0/detailedreportpdf.do";
  	SUMMARY_REPORT_URI = "https://analysiscenter.veracode.com/api/2.0/summaryreport.do";
  	SUMMARY_REPORT_PDF_URI = "https://analysiscenter.veracode.com/api/2.0/summaryreportpdf.do";
  	THIRD_PARTY_REPORT_PDF_URI = "https://analysiscenter.veracode.com/api/2.0/thirdpartyreportpdf.do";
  	
  	def get_application_builds
  	  xml = getXML(GET_APP_BUILDS_URI, @username, @password)
  	  if xml.is_a?(Net::HTTPSuccess)
        builds = Veracode::Result::Builds::Applications.from_xml(xml.body)
      else
        xml.error!
      end
  	end
  	
  	def get_detailed_report(build_id)
  	  xml = getXML(DETAILED_REPORT_URI + "?build_id=" + build_id, @username, @password)
  	  if xml.is_a?(Net::HTTPSuccess)
  	    report = Veracode::Result::DetailedReport.from_xml(xml.body)
  	  else
        xml.error!
      end
  	end
  end
end