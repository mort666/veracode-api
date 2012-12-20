
require 'base64'

# Veracode API General Types used by Summary and Detailed results as well as Application Build API 
#
module Veracode
  module Result 
    # Base Class for result
    class Base
      
      def self.api_field(name, args)  
        send(:define_method, name) do   
          return @xml_hash.send(args[:tag].to_sym) 
        end
      end    
      
      def self.api_type_field(name, args)
        send(:define_method, name) do
          begin
            tmp = eval("@" + name.to_s)  
            tmp ||= args[:as].new(@xml_hash.send(args[:tag].to_sym))
            instance_variable_set("@#{name}", tmp) 
            return tmp
          rescue NoMethodError
          end
        end   
      end
      # Takes Hash of XML stores, hash is has addition to allow dot access to components
      def initialize(xml_hash)
        @xml_hash = xml_hash
      end 
    end
    
    class Screenshot < Base
      api_field :format, :tag => :format            
      
      def data
        @scr_data ||= Base64.decode64(@xml_hash.data)
        
        return @scr_data
      end
      #xml_reader(:data) {|b64data| Base64.decode64(b64data) }
    end
    
    class BulletType < Base
      api_field :text, :tag => :text
    end
    
    class ParaType  < Base
      #xml_reader :bulletitem, :as => [BulletType]
      api_field :text, :tag => :text
      
      def bulletitem
        @bulletitems ||= []
        begin
          if @bulletitems.empty?
            if @xml_hash.bulletitem.class == Array
              @bulletitems = @xml_hash.bulletitem.map do |item|
                BulletType.new(item)
              end
            else
              @bulletitems << BulletType.new(@xml_hash.bulletitem)
            end
          end
        rescue NoMethodError
        end
        return @bulletitems
      end
    end
    
    class TextType < Base
      #xml_reader :text, :from => "text/@text"
    end
    
    class Para < Base
      #xml_reader :para, :as => [ParaType] 
      def para
        @paras ||= []
        if @paras.empty?
          if @xml_hash.para.class == Array
            @paras = @xml_hash.para.map do |para|
              ParaType.new(para)
            end
          else
            @paras << ParaType.new(@xml_hash.para)
          end
        end
        return @paras
      end
    end
    
    class AppendixType < Base
      api_field :description, :tag => :description
      #xml_reader :screenshot, :as => [Screenshot]
      def screenshot
          @screenshots ||= []
          begin
            if @screenshots.empty?
              if @xml_hash.screenshot.class == Array
                @screenshots = @xml_hash.screenshot.map do |screenshot|
                  Screenshot.new(screenshot)
                end
              else
                @screenshots << Screenshot.new(@xml_hash.screenshot)
              end
            end
          rescue NoMethodError
          end
          return @screenshots
        end
      api_field :code, :tag => :code
    end
    
    class Module < Base
      api_field :name, :tag => :name
      api_field :compiler, :tag => :compiler
      api_field :os, :tag => :os
      api_field :architecture, :tag => :architecture
      api_field :score, :tag => :score
      api_field :numflawssev0, :tag => :numflawssev0
      api_field :numflawssev1, :tag => :numflawssev1
      api_field :numflawssev2, :tag => :numflawssev2 
      api_field :numflawssev3, :tag => :numflawssev3 
      api_field :numflawssev4, :tag => :numflawssev4 
      api_field :numflawssev5, :tag => :numflawssev5
    end
    
    class Analysis < Base

      api_field :analysis_size_bytes, :tag => :analysis_size_bytes
      api_field :rating, :tag => :rating
      api_field :score, :tag => :score
      api_field :mitigated_rating, :tag => :mitigated_rating
      api_field :mitigated_score, :tag => :mitigated_score
      api_field :submitted_date, :tag => :submitted_date
      api_field :published_date, :tag => :published_date
      api_field :next_scan_due, :tag => :next_scan_due
      
      def modules
          @modules ||= []
          if @modules.empty?
            if @xml_hash.modules.class == Array
              @modules = @xml_hash.modules.map do |modules|
                Module.new(modules.module)
              end
            else
              @modules << Module.new(@xml_hash.modules.module)
            end
          end
          return @modules
        end
    end
      
    class ManualAnalysis < Base
       api_field :rating, :tag => :rating
       api_field :score, :tag => :score
       api_field :mitigated_rating, :tag => :mitigated_rating
       api_field :mitigated_score, :tag => :mitigated_score
       api_field :submitted_date, :tag => :submitted_date
       api_field :published_date, :tag => :published_date
       api_field :next_scan_due, :tag => :next_scan_due
       api_field :cia_adjustment, :tag => :cia_adjustment
       api_field :delivery_consultant, :tag => :delivery_consultant
       
       def modules
          @modules ||= []
          if @modules.empty?
            if @xml_hash.modules.class == Array
              @modules = @xml_hash.modules.map do |modules|
                Module.new(modules.module)
              end
            else
              @modules << Module.new(@xml_hash.modules.module)
            end
          end
          return @modules
        end
    end
    
    class FlawStatus < Base
      api_field :new_flaws, :tag => :new
      api_field :reopen_flaws, :tag => :reopen
      #api_field :open_flaws, :tag => :open 
      api_field :fixed_flaws, :tag => :fixed
      api_field :total_flaws, :tag => :total
      api_field :not_mitigated, :tag => :not_mitigated
      api_field :sev_1_change, :tag => :sev_1_change 
      api_field :sev_2_change, :tag => :sev_2_change 
      api_field :sev_3_change, :tag => :sev_3_change
      api_field :sev_4_change, :tag => :sev_4_change
      api_field :sev_5_change, :tag => :sev_5_change 
      
      def open_flaws
        return @xml_hash['open']
      end
    end
  end
end