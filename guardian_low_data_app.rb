GUARDIAN_CONTENT_API_KEY = ENV['GUARDIAN_CONTENT_API_KEY']

class GuardianLowDataApp < Sinatra::Base

  set :haml, :format => :html5

  configure :development do
    use BetterErrors::Middleware
    # you need to set the application root in order to abbreviate filenames
    # within the application:
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  GuardianContent::Base.new

  get '/' do
    @results = GuardianContent::Content.search(nil, order_by: 'newest', select: { fields: :all } )

    haml :home
  end

  get '/article/*' do |id|

    @article = GuardianContent::Content.find_by_id(id)

    haml :article
  end
end
