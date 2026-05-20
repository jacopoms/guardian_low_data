# frozen_string_literal: true

describe ApplicationController, { type: :request, vcr: true } do
  describe '@query' do
    it 'does not change once set' do
      get '/'
      expect(last_response.body).to match(/<input name=(['"])q\1 type=(['"])search\2 value=(['"])\3>/)
      post 'search', q: 'foobar'
      expect(last_response.body).to match(/<input name=(['"])q\1 type=(['"])search\2 value=(['"])foobar\3>/)
      get '/page/5'
      expect(last_response.body).to match(/<input name=(['"])q\1 type=(['"])search\2 value=(['"])foobar\3>/)
    end
  end
end
