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

    let(:veracode) { Veracode::API::Base.new(:username => "veracode", :password => "password") }

    it "must have an id attribute" do
      veracode.must_respond_to :username
    end

    it "must have the right id" do
      veracode.username.must_equal 'veracode'
    end

    it "must have an password attribute" do
      veracode.must_respond_to :password
    end

    #it "must have the right password" do
    #  veracode.passwword.must_equal 'password'
    #end

  end
end
