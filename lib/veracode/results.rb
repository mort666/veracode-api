require 'nokogiri'
require 'veracode/parser/parser'
require 'veracode/api/builds'
require 'veracode/api/detailed'
require 'veracode/api/summary'


module Veracode
  module API
    class Results < Veracode::API::Base
      GET_APP_BUILDS_URI = "/api/2.0/getappbuilds.do";
    	DETAILED_REPORT_URI = "/api/2.0/detailedreport.do";
    	DETAILED_REPORT_PDF_URI = "/api/2.0/detailedreportpdf.do";
    	SUMMARY_REPORT_URI = "/api/2.0/summaryreport.do";
    	SUMMARY_REPORT_PDF_URI = "/api/2.0/summaryreportpdf.do";
    	THIRD_PARTY_REPORT_PDF_URI = "/api/2.0/thirdpartyreportpdf.do";
  	
    	def get_application_builds
    	  xml = getXML(GET_APP_BUILDS_URI)
    	  case xml.code
  	    when 200
  	      clean_xml = xml.body.strip
  	      parsed = Veracode::Parser.parse(clean_xml)
          builds = Veracode::Result::Builds::Applications.new(parsed)
        else
          xml.error!
        end
    	end
  	
    	def get_summary_report(build_id)
    	  xml = getXML(SUMMARY_REPORT_URI + "?build_id=" + build_id)
    	  case xml.code
  	    when 200
  	      clean_xml = xml.body.strip
  	      parsed = Veracode::Parser.parse(clean_xml)
  	      report = Veracode::Result::SummaryReport.new(parsed.summaryreport)
    	  else
          xml.error!
        end
    	end
  	
    	def get_detailed_report(build_id)
    	  xml = getXML(DETAILED_REPORT_URI + "?build_id=" + build_id)
    	  case xml.code
  	    when 200
    	    clean_xml = xml.body.strip
  	      parsed = Veracode::Parser.parse(clean_xml)          
    	    report = Veracode::Result::DetailedReport.new(parsed.detailedreport)
    	  else
          xml.error!
        end
    	end
    end 
  end
end