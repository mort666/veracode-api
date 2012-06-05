require 'roxml'

module Veracode 
  module Result
    module Builds
      class AnalysisUnit
        include ROXML
        
        xml_accessor :analysis_type, :from => "@analysis_type"
        xml_accessor :status, :from => "@status"
        xml_accessor :published_date, :from => "@published_date"
      end
      
      class Build
        include ROXML
        
        xml_accessor :version, :from => "@version"
        xml_accessor :build_id, :from =>  "@build_id"
        xml_accessor :submitter, :from => "@submitter"
        xml_accessor :platform, :from => "@platform"
        xml_accessor :lifecycle_stage, :from => "@lifecycle_stage"
        xml_accessor :results_ready, :from => "@results_ready"
        xml_accessor :policy_name, :from => "@policy_name"
        xml_accessor :policy_version, :from => "@policy_version"
        xml_accessor :policy_compliance_status,  :from => "@policy_compliance_status"
        xml_accessor :rules_status, :from => "@rules_status"
        xml_accessor :grace_period_expired, :from => "@grace_period_expired"
        xml_accessor :scan_overdue, :from => "@scan_overdue"

        xml_accessor  :analysis_units, :as => [AnalysisUnit]
      end
      
      class Application
        include ROXML
            
        xml_accessor :app_name, :from => "@app_name"
        xml_accessor :app_id,  :from => "@app_id"
        xml_accessor :industry_vertical,  :from => "@industry_vertical"
        xml_accessor :assurance_level,  :from => "@assurance_level"
        xml_accessor :business_criticality,  :from => "business_criticality"
        xml_accessor :origin,  :from => "@origin"
        xml_accessor :cots,  :from => "@cots"
        xml_accessor :business_unit,  :from => "@business_unit"
        xml_accessor :tags, :from => "@tags"
        xml_accessor :builds, :as => [Build]

      end
      
      class Applications
        include ROXML
        
        xml_accessor :applications, :as => [Application]
      end
              
    end
  end
end
