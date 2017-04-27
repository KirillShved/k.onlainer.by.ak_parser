require 'optparse'
require 'ostruct'
require 'pry'
require 'active_support/core_ext/hash'
require 'nokogiri'
require 'open-uri'

class ParserToUrl

  URL = 'https://ak.api.onliner.by/search/apartments?'.freeze
  REGULAR = /https:\\\/\\\/r.onliner.by\\\/ak\\\/apartments\\\/\d+/
  TOTAL_REGULAR = /"total":(\d+)/

  PAGES_LIMIT = 25
  ITEMS_LIMIT = 30

  attr_reader :url, :url_params, :array_urls, :page_count

  def initialize(url_params = {})
    @url_params = url_params
    @array_urls = []
    @page_count = 0
  end

  def solutions
    array_urls
    puts 'Congratilation, It`s alive!'.freeze
  end

  private

  def input_options
    @url = URL + @url_params.to_query
  end

  def total_pages
    input_options
    sum = Nokogiri::HTML(open(@url)).to_s.scan(TOTAL_REGULAR).join.to_i
    @page_count = (sum / ITEMS_LIMIT.to_f).ceil.clamp(1, PAGES_LIMIT)
  end

  def array_urls
    total_pages
    (1..@page_count).each do |page_number|
      array = Nokogiri::HTML(open(@url.gsub('page=1', "page=#{page_number}"))).to_s.scan(REGULAR).map do |url|
        url.gsub('\/', '/')
      end
      @array_urls << array
    end
    @array_urls.flatten
  end
end
