require "httparty"

require "veracode/version"
require "veracode/config"
require "veracode/base"
require "veracode/upload"
require "veracode/admin"
require "veracode/results"

module Veracode
  module API
    extend Veracode::API::Config
  end
end