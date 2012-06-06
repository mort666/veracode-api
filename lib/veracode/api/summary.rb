require 'veracode/api/types'
require 'veracode/api/flaws'

module Veracode
  module Result
    
      class SummaryCategory < Base
        xml_reader :categoryname, :from => :attr
        xml_reader :severity, :from => :attr
        xml_reader :count, :from => :attr
      end

      class SummarySeverity < Base
        xml_reader :level, :from => "@level"

        xml_reader :categories, :as => [SummaryCategory]
      end
    
    class SummaryReport < Base
      xml_convention :dasherize
      
      xml_reader :report_format_version, :from => "@report_format_version"
      xml_reader :app_name, :from => "@app_name"
      xml_reader :app_id, :from => "@app_id"
      xml_reader :first_build_submitted_date, :from => "@first_build_submitted_date"
      xml_reader :version, :from => "@version"
      xml_reader :build_id, :from => "@build_id"
      xml_reader :vendor, :from => "@vendor"
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
      xml_reader :is_latest_build?, :from => "@is_latest_build"
      xml_reader :policy_name, :from => "@policy_name"
      xml_reader :policy_version, :from => "@policy_version"
      xml_reader :policy_compliance_status, :from => "@policy_compliance_status"
      xml_reader :policy_rules_status, :from => "@policy_rules_status"
      xml_reader :scan_overdue, :from => "@scan_overdue"
      xml_reader :any_type_scan_due, :from => "@any_type_scan_due"
      xml_reader :business_owner, :from => "@business_owner"
      xml_reader :business_unit, :from => "@business_unit"
      xml_reader :tags, :from => "@tags"
      xml_reader :grace_period_expired?, :from => "@grace_period_expired"

      
      xml_reader :static_analysis, :as => Analysis
      xml_reader :dynamic_analysis, :as => Analysis
      xml_reader :manual_analysis, :as => ManualAnalysis
      
      xml_reader :severity, :as => [SummarySeverity]
      
      xml_reader :flaw_status, :as => FlawStatus
    end
  end
end