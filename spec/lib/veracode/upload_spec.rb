require (File.expand_path('./../../../spec_helper', __FILE__))

describe Veracode::API::Upload do
  describe "GET build information" do

    let(:veracode) { Veracode::API::Upload.new(:username => ENV['VERACODE_USER'], :password => ENV['VERACODE_PASS']) }

    before do
      VCR.insert_cassette 'upload', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must have a get_application_list method" do
      veracode.must_respond_to :get_application_list
    end

    it "must parse the api response from XML to Veracode::Upload::ApplicationInfo" do
      veracode.get_application_info("32338").must_be_instance_of Veracode::Upload::ApplicationInfo
    end

    it "must parse the api response from XML to Veracode::Upload::AppList" do
      veracode.get_application_list.must_be_instance_of Veracode::Upload::AppList
    end

    describe "dynamic attributes for build info" do

      before do
        @result = veracode.get_build_info("32338", "44905")
      end

      it "must parse the api response from XML to Veracode::Upload::BuildInfo" do
        @result.must_be_instance_of Veracode::Upload::BuildInfo
      end

      it "must return the attribute value if present" do
        @result.app_id.must_equal "32338"
      end

      it "must be an instance of Veracode::Upload::Build" do
        @result.build.must_be_instance_of Veracode::Upload::Build
      end

      it "must be an instance of TrueClass" do
        @result.build.results_ready?.must_be_instance_of TrueClass
      end

      it "must raise method missing if attribute is not present" do
        lambda { @result.foo_attribute }.must_raise NoMethodError
      end
    end

    describe "dynamic attributes for build list" do

      before do
        @result = veracode.get_build_list("32338")
      end

      it "must parse the api response from XML to Veracode::Upload::BuildList" do
        @result.must_be_instance_of Veracode::Upload::BuildList
      end

      it "must return the attribute value if present" do
        @result.app_id.must_equal "32338"
      end

      it "must raise method missing if attribute is not present" do
        lambda { @result.foo_attribute }.must_raise NoMethodError
      end
    end
  end
end
