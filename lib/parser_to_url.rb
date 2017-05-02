require 'active_support/core_ext/hash'
require 'nokogiri'
require 'open-uri'
require 'pry'

class ParserToUrl

  URL = 'https://ak.api.onliner.by/search/apartments?'.freeze

  PAGES_LIMIT = 25
  ITEMS_LIMIT = 30
  TOTAL = "total".freeze
  APARTMENTS = "apartments".freeze
  URL_PER_PAGE = "url".freeze

  attr_reader :url, :url_params, :array_urls

  def initialize(url_params = {})
    @url_params = url_params
  end

  def call
    puts "Total flats: #{array_urls.length}"
    array_urls
  end

  private

  def array_urls
    @array_urls ||= begin
      (1..total_pages).map do |page_number|
        collection_urls(input_options, page_number)
      end.flatten
    end
  end

  def input_options
    @url ||= URL + @url_params.to_query
  end

  def url_builder(url_base, page_number)
    url_base.gsub('page=1', "page=#{page_number}")
  end

  def json_to_hash(params)
    JSON(Nokogiri::HTML(open(params)))
  end

  def total_pages
    (json_to_hash(input_options)[TOTAL] / ITEMS_LIMIT.to_f).ceil.clamp(1, PAGES_LIMIT)
  end

  def collection_urls(url_base, page_number)
    json_to_hash(url_builder(url_base, page_number))[APARTMENTS].map do |link|
      link[URL_PER_PAGE]
    end
  end
end
