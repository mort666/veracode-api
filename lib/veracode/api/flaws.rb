require 'veracode/api/types'

module Veracode
  module Result
    class AnnotationType < Veracode::Common::Base
      api_field :action, :tag => :action
      api_field :description, :tag => :description
      api_field :user, :tag => :user
      api_field :date, :tag => :date
    end
    
    class Annotations < Veracode::Common::Base
      def annotation
        @annotations ||= [] 
        begin
          if @annotations.empty?
            if @xml_hash.annotation.class == Array 
              @annotations = @xml_hash.annotation.map do |annotation|
                AnnotationType.new(annotation)
              end
            else
              @annotations << AnnotationType.new(@xml_hash.annotation) 
            end
          end
        rescue NoMethodError
        end
        
        return @annotations
      end
    end
    
    class MitigationType < Veracode::Common::Base
      api_field :action, :tag => :action
      api_field :description, :tag => :description
      api_field :user, :tag => :user
      api_field :date, :tag => :date
    end
    
    class Mitigations < Veracode::Common::Base
      def mitigation
        @mitigations ||= [] 
        begin
          if @mitigations.empty?
            if @xml_hash.mitigation.class == Array 
              @mitigations = @xml_hash.mitigation.map do |mitigation|
                MitigationType.new(mitigation)
              end
            else
              @mitigations << MitigationType.new(@xml_hash.mitigation) 
            end
          end
        rescue NoMethodError
        end
        
        return @mitigations
      end
    end
    
    class ExploitabilityAdjustment < Veracode::Common::Base
      api_field :note, :tag => :note
      api_field :score_adjustment, :tag => :score_adjustment
    end
    
    class ExploitAdjustment < Veracode::Common::Base
      def exploitability_adjustment
        @exploitability_adjustments ||= [] 
        begin
          if @exploitability_adjustments.empty?
            if @xml_hash.exploitability_adjustment.class == Array 
              @exploitability_adjustments = @xml_hash.exploitability_adjustment.map do |exploitability_adjustment|
                ExploitabilityAdjustment.new(exploitability_adjustment)
              end
            else
              @exploitability_adjustments << ExploitabilityAdjustment.new(@xml_hash.exploitability_adjustment) 
            end
          end
        rescue NoMethodError
        end
        
        return @exploitability_adjustments
      end
    end
    
    class Flaw < Veracode::Common::Base
      api_field :severity, :tag => :severity
      api_field :categoryname, :tag => :categoryname
      api_field :count, :tag => :count
      api_field :issueid, :tag => :issueid
      api_field :module, :tag => :module
      api_field :type, :tag => :type
      api_field :description, :tag => :description
      api_field :note, :tag => :note
      api_field :cweid, :tag => :cweid
      api_field :remediationeffort, :tag => :remediationeffort
      api_field :exploitlevel, :tag => :exploitLevel
      api_field :categoryid, :tag => :categoryid
      api_field :date_first_occurrence, :tag => :date_first_occurrence
      api_field :remediation_status, :tag => :remediation_status
      api_field :sourcefile, :tag => :sourcefile
      api_field :line, :tag => :line
      api_field :sourcefilepath, :tag => :sourcefilepath
      api_field :scope, :tag => :scope
      api_field :functionprototype, :tag => :functionprototype
      api_field :functionrelativelocation, :tag => :functionrelativelocation
      api_field :url, :tag => :url
      api_field :vuln_parameter, :tag => :vuln_parameter
      api_field :location, :tag => :location
      api_field :cvss, :tag => :cvss
      api_field :capecid, :tag => :capecid
      api_field :exploitdifficulty, :tag => :exploitdifficulty
      api_field :inputvector, :tag => :inputvector
      api_field :cia_impact, :tag => :cia_impact
      api_field :grace_period_expires, :tag => :grace_period_expires
      
      def pcirelated?
        @pcirelated ||= @xml_hash.pcirelated.to_bool
      end
      
      def affects_policy_compliance?
        @affects_policy_compliance ||= @xml_hash.affects_policy_compliance.to_bool
      end
      
      api_field :exploit_desc, :tag => :exploit_desc
      api_field :severity_desc, :tag => :severity_desc
      api_field :remediation_desc, :tag => :remediation_desc
 
      api_type_field :exploitability_adjustments, :tag => :exploitability_adjustments, :as => ExploitAdjustment
      api_type_field :appendix, :tag => :appendix, :as => AppendixType
      api_type_field :mitigations, :tag => :mitigations, :as => Mitigations
      api_type_field :annotations, :tag => :annotations, :as => Annotations
    end
    
    class Flaws < Veracode::Common::Base
      def flaws
        @flaws ||= [] 
        begin
          if @flaws.empty?
            if @xml_hash.flaw.class == Array 
              @flaws = @xml_hash.flaw.map do |flaw|
                Flaw.new(flaw)
              end
            else
              @flaws << Flaw.new(@xml_hash.flaw) 
            end
          end
        rescue NoMethodError
        end
        
        return @flaws
      end
    end
  end
end
      