require 'net/http'
require 'json'

class LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com/'

  def initialize(api_key)
    @api_key = api_key
  end

  def price(symbol)
    endpoint = "#{BASE_URL}price/#{symbol}"
    request_api(endpoint)
  end

  def prices(symbols)
    endpoint = "#{BASE_URL}prices/#{symbols.join(',')}"
    request_api(endpoint)
  end

  def price_all
    endpoint = "#{BASE_URL}price_all"
    request_api(endpoint)
  end

  private

  def request_api(endpoint)
    uri = URI(endpoint)
    request = Net::HTTP::Get.new(uri)
    request['X-RapidAPI-Key'] = @api_key

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end
