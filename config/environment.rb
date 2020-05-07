
require 'bundler'
require 'net/http'
require 'open-uri'
require 'json'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
require 'faker'
require 'ascii'
require 'artii'
require 'colorize'
require 'colorized_string'

# class GetBeers
#     URL = "https://untappd.com/oauth/authenticate/?client_id=CLIENTID&response_type=code&redirect_url=REDIRECT_URL"
   
#     def get_beers
#        uri = URI.parse(URL)
#        response = Net::HTTP.get(uri)
#        json_response = JSON.parse(response)
#     end

    # class GetBreweries
    #     require 'uri'
    #     require 'net/http'
    #     require 'openssl'

    #     URL = URI("https://brianiswu-open-brewery-db-v1.p.rapidapi.com/breweries?by_state=NY&by_name=cooper&by_tag=patio&by_type=micro")

    #     http = Net::HTTP.new(URL.host, URL.port)
    #     http.use_ssl = true
    #     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        
    #     def get_breweries
    #     request = Net::HTTP::Get.new(URL)
    #     request["x-rapidapi-host"] = 'brianiswu-open-brewery-db-v1.p.rapidapi.com'
    #     request["x-rapidapi-key"] = '5988f592a3msh36cd611e9aaeae2p1705a3jsn693188e64232'

    #     response = http.request(request)
    #     puts response.read_body
    #     end
    # end