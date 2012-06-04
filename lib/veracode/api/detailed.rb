require 'veracode/api/parse'

module Veracode
  module Result
    class DetailedReport
      include Veracode::Parser
      
      VALID_ATTRIBUTE_KEYS = [ :report_format_version, :app_name, :app_id, :first_build_submitted_date, :version, :build_id,
                          :submitter, :platform, :assurance_level, :business_criticality, :generation_date, :veracode_level, 
                          :total_flaws, :flaws_not_mitigated, :teams, :life_cycle_stage, :planned_deployment_date, :last_update_time,
                          :is_latest_build, :policy_name, :policy_version, :policy_compliance_status, :policy_rules_status, 
                          :scan_overdue, :any_type_scan_due, :business_owner, :business_unit, :tags, :grace_period_expired].freeze
      
      attr_accessor *VALID_ATTRIBUTE_KEYS
      
      attr_accessor :analysis
      
      def initialize(attributes=nil)
        if !attributes.nil?
          VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
        end
        @analysis = []
      end
      
      def assign(attributes=nil)
        if !attributes.nil?
          VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
        end
      end
      
      class StaticAnalysis
        VALID_ATTRIBUTE_KEYS = [ :rating, :score, :submitted_date, :published_date, :analysis_size_bytes].freeze
        
        attr_accessor *VALID_ATTRIBUTE_KEYS
        attr_accessor :modules
        
        def initialize(attributes)
          VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
          @modules = []
        end
      end
      
      class DynamicAnalysis
        VALID_ATTRIBUTE_KEYS = [ :rating, :score, :submitted_date, :published_date, :analysis_size_bytes].freeze
        
        attr_accessor *VALID_ATTRIBUTE_KEYS
        attr_accessor :modules
        
        def initialize(attributes)
          VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
          @modules = []
        end
      end
      
      class ManualAnalysis
        VALID_ATTRIBUTE_KEYS = [ :rating, :score, :submitted_date, :published_date, :analysis_size_bytes].freeze
        
        attr_accessor *VALID_ATTRIBUTE_KEYS
        attr_accessor :modules, :cia_adjustment
        
        def initialize(attributes)
          VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
          @modules = []
        end
      end
      
      class Modules
        VALID_ATTRIBUTE_KEYS = [ :name, :compiler, :os, :architecture, :score, :numflawssev0, :numflawssev1, 
                            :numflawssev2, :numflawssev3, :numflawssev4, :numflawssev5].freeze

        attr_accessor *VALID_ATTRIBUTE_KEYS

        def initialize(attributes)
          VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
        end
      end
      
      class Severity
        
      end
    end
  end
end