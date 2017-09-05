# spec/app_spec.rb
require_relative 'spec_helper.rb'

describe GuardianLowDataApp do
  it "should allow accessing the home page" do
    VCR.use_cassette('test_homepage') do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
