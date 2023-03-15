require 'uri'
require 'net/http'
require 'openssl'

class LatestStockPrice
  attr_reader :url, :key, :service, :query

  BASE_URL = 'https://latest-stock-price.p.rapidapi.com/'
  HOST = 'latest-stock-price.p.rapidapi.com'

  def initialize(service, query = '', key = nil)
    @service, @key, @query = service.downcase, key, query
    indices_check
    service_check
    generate_url
    key_check
  end

  def http
    obj = Net::HTTP.new(@url.host, @url.port)
    obj.use_ssl = true
    obj.verify_mode = OpenSSL::SSL::VERIFY_NONE
    obj
  end

  def request
    obj = Net::HTTP::Get.new(url)
    obj["X-RapidAPI-Key"] = key
    obj["X-RapidAPI-Host"] = HOST
    obj
  end

  def response
    http.request(request)
  end

  def exec
    response.read_body
  end

  private

  def indices_check
    raise NoIndices if service.match?(/price/) && !query.downcase.match?('indices')
  end

  def service_check
    raise ServiceUnknown unless service.match?(/price|any/)
  end

  def generate_url
    uri = "#{BASE_URL}#{service}"
    uri = "#{uri}?#{query}" unless service == 'any'
    @url = URI(uri)
  end

  def key_check
    @key = key || Rails.application.credentials.rapid_api[:key]
    raise MissingKey if @key.nil?
  end
end
