require 'veracode/api/types'

module Veracode
  module Result
    class Call < Veracode::Common::Base
      api_field :data_path, :tag => :data_path
      api_field :file_path, :tag => :file_path
      api_field :function_name, :tag => :function_name
      api_field :line_number, :tag => :line_number
    end       
    
    class CallStack < Veracode::Common::Base
      api_field :module_name, :tag => :module_name
      api_field :steps, :tag => :steps
      api_field :local_path, :tag => :local_path
      api_field :function_name, :tag => :function_name
      api_field :line_number, :tag => :line_number
      
      def calls
        @calls ||= []
        begin  
          if @calls.empty?      
            if @xml_hash.call.class == Array
              @calls = @xml_hash.call.map do |item|
                Call.new(item)
              end
            else
              @calls << Call.new(@xml_hash.call)
            end
          end
        rescue NoMethodError
        end
        return @calls
      end
    end
    
    class CallStacks < Veracode::Common::Base
      api_field :build_id, :tag => :build_id
      api_field :flaw_id, :tag => :flaw_id
      
      def callstack
        @callstacks ||= []
        begin  
          if @callstacks.empty?      
            if @xml_hash.callstack.class == Array
              @callstacks = @xml_hash.callstack.map do |item|
                CallStack.new(item)
              end
            else
              @callstacks << CallStack.new(@xml_hash.callstack)
            end
          end
        rescue NoMethodError
        end
        return @callstacks
      end
    end
  end
end