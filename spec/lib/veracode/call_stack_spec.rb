require (File.expand_path('./../../../spec_helper', __FILE__))

describe Veracode::API::Results do
  describe "GET Call Stack" do

    let(:veracode) { Veracode::API::Results.new(:veracode_id => ENV['VERACODE_ID'], :veracode_key => ENV['VERACODE_KEY']) }

    before do
      VCR.insert_cassette 'call_stack', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must have a get_callstacks method" do
      veracode.must_respond_to :get_callstacks
    end

    # it "must parse the api response from XML to Veracode::Result::CallStacks" do
    #   veracode.get_callstacks("44905", "132").must_be_instance_of Veracode::Result::CallStacks
    # end
  end
end
