require 'veracode/api/types'

module Veracode 
  module Result
    module Builds 
      class AnalysisUnit < Veracode::Common::Base 
        api_field :analysis_type, :tag => :analysis_type
        api_field :status, :tag => :status
        api_field :published_date, :tag => :published_date
      end
      
      class Build < Veracode::Common::Base 
        api_field :version, :tag => :version
        api_field :build_id, :tag => :build_id
        api_field :submitter, :tag => :submitter
        api_field :platform, :tag => :platform
        api_field :lifecycle_stage, :tag => :lifecycle_stage
        api_field :policy_name, :tag => :policy_name
        api_field :policy_version, :tag => :policy_version
        api_field :policy_compliance_status, :tag => :policy_compliance_status
        api_field :rules_status, :tag => :rules_status
        
        def grace_period_expired?
          @grace_period_expired ||= @xml_hash.grace_period_expired.to_bool
        end
        
        def scan_overdue?
          @scan_overdue ||= @xml_hash.scan_overdue.to_bool
        end
        
        def results_ready?
          @results_ready ||= @xml_hash.results_ready.to_bool
        end
                
        def analysis_units
          @analysis_units ||= []
          if @analysis_units.empty?
            if @xml_hash.analysis_unit.class == Array
              @analysis_units = @xml_hash.analysis_unit.map do |analysis_unit|
                AnalysisUnit.new(analysis_unit)
              end
            else
              @analysis_units << AnalysisUnit.new(@xml_hash.analysis_unit)
            end
          end
          return @analysis_units
        end
      end

      class CustomField < Veracode::Common::Base
        api_field :name, :tag => :name
        api_field :value, :tag => :value
      end

      class Application < Veracode::Common::Base
        api_field :app_name, :tag => :app_name
        api_field :app_id, :tag => :app_id
        api_field :industry_vertical, :tag => :industry_vertical
        api_field :assurance_level, :tag => :assurance_level
        api_field :business_criticality, :tag => :business_criticality
        api_field :origin, :tag => :origin
        api_field :business_unit, :tag => :business_unit
        api_field :business_owner, :tag => :business_owner
        api_field :modified_date, :tag => :modified_date
        api_field :vendor, :tag => :vendor
        api_field :tags, :tag => :tags

        def custom_fields
          @custom_fields ||=
              @xml_hash.customfield.map do |customfield|
                CustomField.new(customfield)
              end
        end

        def cots?
          @cots ||= @xml_hash.cots.to_bool
        end
        
        def builds
          @builds ||= []
          if @builds.empty?
            if @xml_hash.build.class == Array
              @builds = @xml_hash.build.map do |build|
                Build.new(build)
              end
            else
              @builds << Build.new(@xml_hash.build)
            end
          end
          return @builds
        end        
      end
      
      class Applications < Veracode::Common::Base
        def applications
          @applications ||= []
          if @applications.empty?
            @applications = @xml_hash.applicationbuilds.application.map do |application|
              Application.new(application)
            end
          end
        end
      end
              
    end
  end
end
