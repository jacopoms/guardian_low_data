# frozen_string_literal: true

describe ApplicationController, { type: :request, vcr: true } do
  describe '@query' do
    # rubocop:disable RSpec/ExampleLength
    # rubocop:disable RSpec/MultipleExpectations
    it 'does not change once set' do
      get '/'
      expect(last_response.body).to include("<input name='q' type='search'>")
      post 'search', q: 'foobar'
      expect(last_response.body).to include("<input name='q' type='search' value='foobar'>")
      get '/page/5'
      expect(last_response.body).to include("<input name='q' type='search' value='foobar'>")
    end
    # rubocop:enable RSpec/ExampleLength
    # rubocop:enable RSpec/MultipleExpectations
  end
end
