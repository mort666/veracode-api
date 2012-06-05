require 'veracode/api/types'

module Veracode
  module Result
    class Modules < Base
      xml_reader :name, :from => "@name"
      xml_reader :compiler, :from => "@compiler"
      xml_reader :os, :from => "@os"
      xml_reader :architecture, :from => "@architecture"
      xml_reader :score, :from => "@score"
      xml_reader :numflawssev0, :from => "@numflawssev0"
      xml_reader :numflawssev1, :from => "@numflawssev1"
      xml_reader :numflawssev2, :from => "@numflawssev2" 
      xml_reader :numflawssev3, :from => "@numflawssev3" 
      xml_reader :numflawssev4, :from => "@numflawssev4" 
      xml_reader :numflawssev5, :from => "@numflawssev5"
    end
    
    class Analysis < Base
      xml_reader :rating, :from => "@rating"
      xml_reader :score, :from => "@score"
      xml_reader :submitted_date, :from => "@submitted_date"
      xml_reader :published_date, :from => "@published_date"
      xml_reader :mitigated_rating, :from => "@mitigated_rating"
      xml_reader :mitigated_score, :from => "@mitigated_score"
      xml_reader :analysis_size_bytes, :from => "@analysis_size_bytes"
      xml_reader :next_scan_due, :from => "@next_scan_due"
      
      xml_reader :modules, :as => [Modules]
    end
      
    class ManualAnalysis < Base
      xml_reader :rating, :from => "@rating"
      xml_reader :score, :from => "@score"
      xml_reader :mitigated_rating, :from => "@mitigated_rating"
      xml_reader :mitigated_score, :from => "@mitigated_score"
      xml_reader :submitted_date, :from => "@submitted_date"
      xml_reader :published_date, :from => "@published_date"
      xml_reader :next_scan_due, :from => "@next_scan_due"

      xml_reader :modules, :as => [Modules]
      xml_reader :cia_adjustment
      xml_reader :delivery_consultant
    end
    
    class CWE < Base
      xml_reader :cweid, :from => "@cweid"
      xml_reader :cwename, :from => "@cwename"
      xml_reader :pcirelated?, :from => "@pcirelated"
      
      xml_reader :description, :as => [TextType]
    end
    
    class Category < Base
      xml_reader :categoryid, :from => "@categoryid"
      xml_reader :categoryname, :from => "@categoryname"
      xml_reader :pcirelated?, :from => "pcirelated"
      
      xml_reader :desc, :as => Para
      xml_reader :recommendations, :as => Para
      xml_reader :cwe, :as => [CWE]
    end
      
    class Severity < Base
      xml_reader :level, :from => "@level"
      
      xml_reader :categories, :as => [Category]
    end
    
    class DetailedReport < Base
      xml_convention :dasherize
      
      xml_reader :report_format_version, :from => "@report_format_version"
      xml_reader :app_name, :from => "@app_name"
      xml_reader :app_id, :from => "@app_id"
      xml_reader :first_build_submitted_date, :from => "@first_build_submitted_date"
      xml_reader :version, :from => "@version"
      xml_reader :build_id, :from => "@build_id"
      xml_reader :submitter, :from => "@submitter"
      xml_reader :platform, :from => "@platform"
      xml_reader :assurance_level, :from => "@assurance_level"
      xml_reader :business_criticality, :from => "@business_criticality"
      xml_reader :generation_date, :from => "@generation_date"
      xml_reader :veracode_level, :from => "@veracode_level"
      xml_reader :total_flaws, :from => "@total_flaws"
      xml_reader :flaws_not_mitigated, :from => "@flaws_not_mitigated"
      xml_reader :teams, :from => "@teams"
      xml_reader :life_cycle_stage, :from => "@life_cycle_stage"
      xml_reader :planned_deployment_date, :from => "@planned_deployment_date"
      xml_reader :last_update_time, :from => "@last_update_time"
      xml_reader :is_latest_build, :from => "@is_latest_build"
      xml_reader :policy_name, :from => "@policy_name"
      xml_reader :policy_version, :from => "@policy_version"
      xml_reader :policy_compliance_status, :from => "@policy_compliance_status"
      xml_reader :policy_rules_status, :from => "@policy_rules_status"
      xml_reader :scan_overdue, :from => "@scan_overdue"
      xml_reader :any_type_scan_due, :from => "@any_type_scan_due"
      xml_reader :business_owner, :from => "@business_owner"
      xml_reader :business_unit, :from => "@business_unit"
      xml_reader :tags, :from => "@tags"
      xml_reader :grace_period_expired, :from => "@grace_period_expired"

      
      xml_reader :static_analysis, :as => Analysis
      xml_reader :dynamic_analysis, :as => Analysis
      xml_reader :manual_analysis, :as => ManualAnalysis
      
      xml_reader :severity, :as => [Severity]
      
    end
    
  end
end