require 'veracode/api/parse'

module Veracode 
  module Result
    module Builds
      class Applications
        include Veracode::Parser
        attr_accessor :applications

        @applications
    
        def initialize
          @applications = []
        end
        
        class Application
            VALID_ATTRIBUTE_KEYS = [ :app_name, :app_id, :industry_vertical, :assurance_level, 
                                :business_criticality, :origin, :cots, :business_unit, :tags ].freeze

            attr_accessor *VALID_ATTRIBUTE_KEYS

            attr_accessor :builds

            def initialize(attributes)
              @builds = []
                VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
            end   

            class Build
              VALID_ATTRIBUTE_KEYS = [ :version, :build_id, :submitter, :platform, :lifecycle_stage, :results_ready, :policy_name, 
                                 :policy_version, :policy_compliance_status, :rules_status, :grace_period_expired,
                                 :scan_overdue ].freeze

              attr_accessor *VALID_ATTRIBUTE_KEYS
              attr_accessor :units

              def initialize(attributes)
                VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
                  @units = []
              end  

              class AnalysisUnit
                VALID_ATTRIBUTE_KEYS = [ :analysis_type, :status, :published_date ].freeze
                
                attr_accessor *VALID_ATTRIBUTE_KEYS
                
                def initialize(attributes)
                  VALID_ATTRIBUTE_KEYS.each{|k| self.send("#{k}=", Hash[attributes][k.to_s]) }
                end
              end  
            end 
        end
      end
    end
  end
end
