require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "ab3fcb9996e6bdbb5bf3ca59bde5a725"

get "/" do
    view "ask"
  # show a view that asks for the location
end

get "/news" do
    results = Geocoder.search(params["location"]) 
    lat_long = results.first.coordinates # => [lat,long]
    lat = lat_long[0]
    long = lat_long[1]


@forecast = ForecastIO.forecast("#{lat}","#{long}").to_hash
@current_temp = @forecast["currently"]["temperature"]


url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ec33d05952e94bb79e891a491a52a49c"
news = HTTParty.get(@url).parsed_response.to_hash

end