require 'veracode/api/types'

module Veracode
  module Upload 
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
    
    class BuildInfo < Veracode::Common::Base 
      api_field :build_id, :tag => :build_id
      api_field :app_id, :tag => :app_id
      api_field :account_id, :tag => :account_id
      
      api_type_field :build, :tag => :build, :as => Build        
    end
    
    class BuildList < Veracode::Common::Base
      api_field :app_id, :tag => :app_id
      api_field :account_id, :tag => :account_id
      api_field :app_name, :tag => :app_name
      
      def build
        @builds ||= []
        begin  
          if @builds.empty?      
            if @xml_hash.build.class == Array
              @builds = @xml_hash.build.map do |item|
                Build.new(item)
              end
            else
              @builds << Build.new(@xml_hash.build)
            end
          end
        rescue NoMethodError
        end
        return @builds
      end
    end
    
    class Application < Veracode::Common::Base
      api_field :app_id, :tag => :app_id
      api_field :app_name, :tag => :app_name
      api_field :vendor, :tag => :vendor
      api_field :description, :tag => :description
      api_field :business_criticality, :tag => :business_criticality
      api_field :policy, :tag => :policy
      api_field :teams, :tag => :teams
      api_field :origin, :tag => :origin
      api_field :industry_vertical, :tag => :industry_vertical
      api_field :app_type, :tag => :app_type
      api_field :deployment_method, :tag => :deployment_method
      api_field :archer_app_name, :tag => :archer_app_name
      api_field :modified_date, :tag => :modified_date
      api_field :vendor_id, :tag => :vendor_id
      api_field :business_unit, :tag => :business_unit
      api_field :business_owner, :tag => :business_owner
      api_field :business_owner_email, :tag => :business_owner_email
      api_field :tags, :tag => :tags
      
      def is_web_application?
        @is_web_application ||= @xml_hash.is_web_application.to_bool
      end
      
      def cots?
        @cots ||= @xml_hash.cots.to_bool
      end 
    end
    
    class ApplicationInfo < Veracode::Common::Base 
      def application
        @applications ||= []
        begin  
          if @applications.empty?      
            if @xml_hash.application.class == Array
              @applications = @xml_hash.application.map do |item|
                Application.new(item)
              end
            else
              @applications << Application.new(@xml_hash.application)
            end
          end
        rescue NoMethodError
        end
        return @applications
      end
    end
  
    class App < Veracode::Common::Base
      api_field :app_id, :tag => :app_id
      api_field :app_name, :tag => :app_name
      api_field :vendor_name, :tag => :vendor_name
    end
    
    class AppList < Veracode::Common::Base
      api_field :account_id, :tag => :account_id 
      
      def app
        @applications ||= []
        begin  
          if @applications.empty?      
            if @xml_hash.app.class == Array
              @applications = @xml_hash.app.map do |item|
                App.new(item)
              end
            else
              @applications << App.new(@xml_hash.app)
            end
          end
        rescue NoMethodError
        end
        return @applications
      end
    end
  end
end