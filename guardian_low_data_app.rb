class GuardianLowDataApp < Sinatra::Base

  set :haml, :format => :html5

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  before do
    if defined?(GUARDIAN_CONTENT_API_KEY)
      GuardianContent.new(GUARDIAN_CONTENT_API_KEY)
    else
      GuardianContent.new(ENV['GUARDIAN_CONTENT_API_KEY'])
    end
  end

  get '/' do
    @results = GuardianContent::Content.search(nil, order: 'newest', select: { fields: :all } )
    p @results.first
    haml :home
  end

  get '/article/*' do |id|
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end
end
