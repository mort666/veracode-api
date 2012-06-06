require 'veracode/api/types'

module Veracode 
  module Result
    module Builds
      class AnalysisUnit < Base
        xml_reader :analysis_type, :from => "@analysis_type"
        xml_reader :status, :from => "@status"
        xml_reader :published_date, :from => "@published_date"
      end
      
      class Build < Base
        xml_reader :version, :from => "@version"
        xml_reader :build_id, :from =>  "@build_id"
        xml_reader :submitter, :from => "@submitter"
        xml_reader :platform, :from => "@platform"
        xml_reader :lifecycle_stage, :from => "@lifecycle_stage"
        xml_reader :results_ready, :from => "@results_ready"
        xml_reader :policy_name, :from => "@policy_name"
        xml_reader :policy_version, :from => "@policy_version"
        xml_reader :policy_compliance_status,  :from => "@policy_compliance_status"
        xml_reader :rules_status, :from => "@rules_status"
        xml_reader :grace_period_expired, :from => "@grace_period_expired"
        xml_reader :scan_overdue, :from => "@scan_overdue"

        xml_reader  :analysis_units, :as => [AnalysisUnit]
      end
      
      class Application < Base
        xml_reader :app_name, :from => "@app_name"
        xml_reader :app_id,  :from => "@app_id"
        xml_reader :industry_vertical,  :from => "@industry_vertical"
        xml_reader :assurance_level,  :from => "@assurance_level"
        xml_reader :business_criticality,  :from => "business_criticality"
        xml_reader :origin,  :from => "@origin"
        xml_reader :cots,  :from => "@cots"
        xml_reader :business_unit,  :from => "@business_unit"
        xml_reader :tags, :from => "@tags"
        xml_reader :builds, :as => [Build]

      end
      
      class Applications < Base
        xml_reader :applications, :as => [Application]
      end
              
    end
  end
end
