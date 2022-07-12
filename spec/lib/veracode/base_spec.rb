require (File.expand_path('./../../../spec_helper', __FILE__))

describe Veracode::API::Base do

  describe "default attributes" do

    it "must include httparty methods" do
      Veracode::API::Base.must_include HTTParty
    end

    it "must have the base url set to the Veracode API endpoint" do
      Veracode::API::Base.base_uri.must_equal 'https://analysiscenter.veracode.com'
    end
  end

  describe "default instance attributes" do

    let(:veracode) { Veracode::API::Base.new(:veracode_id => "veracode_id", :veracode_key => "veracode_key") }

    it "must have an id attribute" do
      veracode.must_respond_to :veracode_id
    end

    it "must have the right id" do
      veracode.veracode_id.must_equal 'veracode_id'
    end

    it "must have an password attribute" do
      veracode.must_respond_to :veracode_key
    end

    #it "must have the right password" do
    #  veracode.passwword.must_equal 'password'
    #end

  end
end
