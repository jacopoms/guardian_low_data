# frozen_string_literal: true

describe ApplicationController, :vcr do
  context 'testing the happy path' do
    before do
      get path
    end

    context 'when get /' do
      let(:path) { '/' }
      it 'is successful' do
        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)
      end

      it 'renders the homepage as expected' do
        expect(last_response.body).to include("class='article-title'")
      end
    end

    context 'when get /page/2' do
      let(:path) { '/page/2' }
      it 'is successful' do
        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)
      end

      it 'renders the second page as expected' do
        expect(last_response.body).to include('')
      end
    end

    context 'when get /page/21' do
      let(:path) { '/page/21' }
      it 'is successful' do
        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)
      end

      it 'renders the page as expected' do
        expect(last_response.body).to include('No Articles')
      end
    end

  end
  context 'testing the unhappy path' do
    context 'when get /page/abc' do
      let(:path) { '/page/abc' }
      it 'throws the expected error' do
        expect { get path }.to raise_exception(RangeError)
      end
    end
  end

  describe "Search" do
    context 'when post /search?q=foobar' do
      let(:search_term) { 'foobar' }
      it "is successfull" do
        post '/search', :q => search_term
        expect(last_response.body).to include(search_term)
      end
    end
  end
end
