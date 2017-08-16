class GuardianLowDataApp < Sinatra::Base

  set :haml, :format => :html5

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end
  
  before do
    GuardianContent::Base.new(ENV['GUARDIAN_CONTENT_API_KEY'])
  end

  get '/' do
    @results = GuardianContent::Content.search("Britain", order: 'newest', select: { fields: :all } )
    haml :home
  end

  get '/article/*' do |id|
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end
end
