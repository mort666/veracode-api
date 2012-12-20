# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "veracode/version"

Gem::Specification.new do |s|
  s.name        = "veracode-api"
  s.version     = Veracode::API::VERSION
  s.authors     = ["Stephen Kapp"]
  s.email       = ["mort666@virus.org"]
  s.homepage    = "https://github.com/mort666/veracode-api"
  s.summary     = %q{Veracode Analysis Service API Wrapper}
  s.description = %q{Ruby API Wrapper to access Veracode Security Analysis Service API}

  s.rubyforge_project = "veracode-api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "httparty"
  s.add_dependency "rexml"
  s.add_dependency "nori"
  s.add_dependency "nokogiri"
  s.add_dependency "xml-simple"
  s.add_dependency "roxml"
  s.add_dependency "i18n"

end
