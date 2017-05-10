require 'active_support/core_ext/hash'
require 'nokogiri'
require 'net/http'
require_relative 'collection_urls_per_page'

class ParserToUrl

  URL = 'https://ak.api.onliner.by/search/apartments?'.freeze

  PAGES_LIMIT = 25
  ITEMS_LIMIT = 30
  TOTAL = "total".freeze

  attr_reader :url, :url_params, :array_urls

  def initialize(url_params = {})
    @url_params = url_params
  end

  def call
    @array_urls ||= begin
      (1..total_pages).map do |page_number|
        CollectionUrlsPerPage.new(url_base, page_number).call
      end.flatten
    end
  end

  private

  def total_pages
    (JSON(Nokogiri::HTML(Net::HTTP.get(URI(url_base))))[TOTAL] / ITEMS_LIMIT.to_f).ceil.clamp(1, PAGES_LIMIT)
  end

  def url_base
    @url ||= URL + @url_params.to_query
  end
end
