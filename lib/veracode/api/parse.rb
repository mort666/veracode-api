module Veracode
  module Parser
    def parse(xml_text, on_error = nil, on_warning = nil)
        sax_handler = Handler.new(self, on_error, on_warning)
        parser = Nokogiri::XML::SAX::Parser.new(sax_handler)
        parser.parse(xml_text)
        self
    end
  end
  
  class Handler < Nokogiri::XML::SAX::Document 
  attr_reader :stack
  
  def initialize(object, on_error = nil, on_warning = nil)
    @stack = [[object, nil, String.new]]
    @parsed_configs = {}
    @on_error = on_error
    @on_warning = on_warning
  end
  
  def characters(string)
    object, config, value = stack.last
    
    value << string
  end
  
  def cdata_block(string)
    characters(string)
  end
  
  def start_element name, attrs = []
    object, config, value = stack.last
    
    case name
    when "application"
      app = Veracode::Result::Builds::Applications::Application.new(attrs)
      object.applications.push(app)
    when "build"
      build = Veracode::Result::Builds::Applications::Application::Build.new(attrs)
      object.applications.last.builds.push(build)
    when "analysis_unit"
      analysis = Veracode::Result::Builds::Applications::Application::Build::AnalysisUnit.new(attrs)
      object.applications.last.builds.last.units.push(analysis)
    when "detailedreport"  
      object.assign(attrs)
    when "static-analysis"
      analysis = Veracode::Result::DetailedReport::StaticAnalysis.new(attrs)
      object.analysis.push(analysis)
    when "dynamic-analysis"
      analysis = Veracode::Result::DetailedReport::DynamicAnalysis.new(attrs)
      object.analysis.push(analysis)
    when "manual-analysis"
      analysis = Veracode::Result::DetailedReport::ManualAnalysis.new(attrs)
      object.analysis.push(analysis)
    when "cia_adjustment"
      object.analysis.last.cia_adjustment = nil
    when "module"
      mod = Veracode::Result::DetailedReport::Modules.new(attrs)
      object.analysis.last.modules.push(mod)
    else
    end
  end

  def warning string
    if @on_warning
      @on_warning.call(string)
    end
  end

  def error string
    if @on_error
      @on_error.call(string)
    end
  end

  def end_element name
    object, config, value = stack.last
    
    case name
    when "screen"
    when "cia_adjustment"
      object.analysis.last.cia_adjustment = value.to_i
    else
    end
  end
end
end