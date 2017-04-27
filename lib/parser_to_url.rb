require 'optparse'
require 'ostruct'
require 'pry'
require 'active_support/core_ext/hash'
require 'nokogiri'
require 'open-uri'
require 'json'

class ParserToUrl

  URL = 'https://ak.api.onliner.by/search/apartments?'.freeze
  REGULAR = /https:\\\/\\\/r.onliner.by\\\/ak\\\/apartments\\\/\d+/
  TOTAL_REGULAR = /"total":(\d+)/

  PAGES_LIMIT = 25
  ITEMS_LIMIT = 30

  attr_reader :url, :url_params, :array_urls, :page_count, :my_hash

  def initialize(url_params = {})
    @url_params = url_params
    @array_urls = []
    @page_count = 0
  end

  def array_urls
    @array_urls ||= begin
      (1..total_pages).map do |page_number|
        Nokogiri::HTML(open(UrlBuilder.new(input_options, page_number).call)).to_s.scan(REGULAR).map do |url|
          url.gsub('\/', '/')
        end
      end.flatten
    end
    binding.pry

  end

  private

  def input_options
    @url ||= URL + @url_params.to_query
  end

  def total_pages
    @page_count ||= begin
      sum = Nokogiri::HTML(open(input_options)).to_s.scan(TOTAL_REGULAR).join.to_i
      (sum / ITEMS_LIMIT.to_f).ceil.clamp(1, PAGES_LIMIT)
    end
  end

  class UrlBuilder

    attr_reader :page_number, :url_base

    def initialize(url_base, page_number)
      @url_base = url_base
      @page_number = page_number
    end

    def call
      url_base.gsub('page=1', "page=#{page_number}")
    end
  end

  # def json_to_hash(urls, page_number)
  #   @my_hash ||= begin
  #
  #   end
  # end
end
