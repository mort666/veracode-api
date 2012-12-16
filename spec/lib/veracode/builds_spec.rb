require (File.expand_path('./../../../spec_helper', __FILE__))

describe Veracode::API::Results do
  describe "GET builds" do

    let(:veracode) { Veracode::API::Results.new(:username => "test", :password => "test") }

    before do
      VCR.insert_cassette 'base', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must have a get_application_builds method" do
      veracode.must_respond_to :get_application_builds
    end
    
    it "must parse the api response from XML to Veracode::Result::Builds::Applications" do
      veracode.get_application_builds.must_be_instance_of Veracode::Result::Builds::Applications
    end
    
    describe "dynamic attributes for builds" do

      before do
        @builds = veracode.get_application_builds
      end

      it "must raise method missing if attribute is not present" do
        lambda { @builds.foo_attribute }.must_raise NoMethodError
      end
    end
  end
end
