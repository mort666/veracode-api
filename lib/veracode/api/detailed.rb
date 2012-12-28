require 'veracode/api/types'
require 'veracode/api/flaws'

module Veracode
  module Result
    class CWE < Veracode::Common::Base
      api_field :cweid, :tag => :cweid
      api_field :cwename, :tag => :cwename
      
      def pcirelated?
        @pcirelated ||= @xml_hash.pcirelated.to_bool
      end
      
      def description
        @xml_hash.description.text.text
      end

      api_type_field :manualflaws, :tag => :manualflaws, :as => Flaws
      api_type_field :dynamicflaws, :tag => :dynamicflaws, :as => Flaws
      api_type_field :staticflaws, :tag => :staticflaws, :as => Flaws

    end
    
    class Category < Veracode::Common::Base 
      api_field :categoryid, :tag => :categoryid
      api_field :categoryname, :tag => :categoryname
      api_type_field :desc, :tag => :desc, :as => Para 
      api_type_field :recommendations, :tag => :recommendations, :as => Para 
      
      def pcirelated?
        @pcirelated ||= @xml_hash.pcirelated.to_bool
      end
      
      def description
        temp = self.desc.para.map do |para|
          para.text
        end       
        
        self.desc.para.map do |para|
          if !para.bulletitem.nil?
            x = para.bulletitem.each.map do |item|
              "* " + item.text + "\r\n"
            end
          end
          temp << x.join
        end 
        
        return temp.join("\r\n\r\n").strip
      end
   
      def recommendation
        temp = self.recommendations.para.map do |para|
          para.text
        end       
        
        self.recommendations.para.map do |para|
          if !para.bulletitem.nil?
            x = para.bulletitem.each.map do |item|
              "* " + item.text + "\r\n"
            end
          end
          temp << x.join
        end 
        
        return temp.join("\r\n\r\n").strip
      end

      def cwe
        @cwe ||= [] 
        begin
          if @cwe.empty?
            if @xml_hash.cwe.class == Array 
              @cwe = @xml_hash.cwe.map do |c|
                CWE.new(c)
              end
            else
              @cwe << CWE.new(@xml_hash.cwe) 
            end
          end
        rescue NoMethodError
        end
        
        return @cwe
      end
    end
    
    class Severity < Veracode::Common::Base
      api_field :level, :tag => :level
      
      def categories
        @categories ||= [] 
        begin
          if @categories.empty?
            if @xml_hash.category.class == Array 
              @categories = @xml_hash.category.map do |sev|
                Category.new(sev)
              end
            else
              @categories << Category.new(@xml_hash.category) 
            end
          end
        rescue NoMethodError
        end
        
        return @categories
      end
    end
    
    class DetailedReport < Veracode::Common::Base
      
      api_field :report_format_version, :tag => :report_format_version
      api_field :app_name, :tag => :app_name
      api_field :app_id, :tag => :app_id
      api_field :first_build_submitted_date, :tag => :first_build_submitted_date
      api_field :version, :tag => :version
      api_field :build_id, :tag => :build_id
      api_field :submitter, :tag => :submitter
      api_field :vendor, :tag => :vendor
      api_field :platform, :tag => :platform
      api_field :assurance_level, :tag => :assurance_level
      api_field :business_criticality, :tag => :business_criticality
      api_field :generation_date, :tag => :generation_date
      api_field :veracode_level, :tag => :veracode_level
      api_field :total_flaws, :tag => :total_flaws
      api_field :flaws_not_mitigated, :tag => :flaws_not_mitigated
      api_field :teams, :tag => :teams
      api_field :life_cycle_stage, :tag => :life_cycle_stage
      api_field :planned_deployment_date, :tag => :planned_deployment_date
      api_field :last_update_time, :tag => :last_update_time
      api_field :policy_name, :tag => :policy_name
      api_field :policy_version, :tag => :policy_version
      api_field :policy_compliance_status, :tag => :policy_compliance_status
      api_field :policy_rules_status, :tag => :policy_rules_status
      api_field :scan_overdue, :tag => :scan_overdue
      api_field :any_type_scan_due, :tag => :any_type_scan_due
      api_field :business_owner, :tag => :business_owner
      api_field :business_unit, :tag => :business_unit
      api_field :tags, :tag => :tags
      
      api_type_field :static_analysis, :tag => :static_analysis, :as => Analysis
      api_type_field :dynamic_analysis, :tag => :dynamic_analysis, :as => Analysis
      api_type_field :manual_analysis, :tag => :manual_analysis, :as => ManualAnalysis
      api_type_field :flaw_status, :tag => :flaw_status, :as => FlawStatus
      
      def is_latest_build?
        @is_latest_build ||= @xml_hash.is_latest_build.to_bool
      end
      
      def grace_period_expired?
        @grace_period_expired ||= @xml_hash.grace_period_expired.to_bool
      end      
      
      def severity
        @severity ||= []
        if @severity.empty?
          if @xml_hash.severity.class == Array
            @severity = @xml_hash.severity.map do |sev|
              Severity.new(sev)
            end
          else
            @severity << Severity.new(@xml_hash.severity)
          end
        end
        return @severity
      end
    end
    
  end
end