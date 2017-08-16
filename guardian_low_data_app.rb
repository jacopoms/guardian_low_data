
class GuardianLowDataApp < Sinatra::Base

  GUARDIAN_CONTENT_API_KEY = ENV['GUARDIAN_CONTENT_API_KEY']
 
  set :haml, :format => :html5

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  GuardianContent::Base.new

  get '/' do
    @results = GuardianContent::Content.search("Britain", order: 'newest', select: { fields: :all } )
    haml :home
  end

  get '/article/*' do |id|
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end
end
