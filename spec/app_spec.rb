# spec/app_spec.rb
require_relative "spec_helper.rb"

describe GuardianLowDataApp do
  describe "/" do
    it "should allow accessing the home page" do
      VCR.use_cassette("test_homepage") do
        get "/"
        expect(last_response).to be_ok
      end
    end
  end

  describe "#prepare_articles" do
    let(:test_subject) { app.new! }

    it "should return one Openstruct if passed an empty Array" do
      results = test_subject.prepare_articles([])
      expect(results).to be_kind_of(Array)
      result = results.first
      expect(result).to be_kind_of(OpenStruct)
      expect(result).to respond_to(:title)
      expect(result.title).to be == "No Articles"
    end

    it "should return the same collection if passed a no empty collection" do
      collection = [1, 2, 3]
      results = test_subject.prepare_articles(collection)
      expect(results).to be == collection
    end
  end
end
