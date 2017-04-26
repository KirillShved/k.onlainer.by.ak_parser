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

  PAGE = { limit: 30 }.freeze

  attr_reader :url, :url_params, :array_urls, :page_count, :number_page

  def initialize(url_params = {})
    @url_params = url_params
    @array_urls = [],
    @page_count = 0
    @number_page = 1
  end

  def solutions
    array_urls
  end

  private

  def input_options
    @url = URL + @url_params.to_query
  end

  def total_pages
    input_options
    puts total = Nokogiri::HTML(open(@url)).to_s.scan(TOTAL_REGULAR).join.to_i
    sum_page = total / PAGE[:limit]

    if sum_page < 25
      puts @page_count = sum_page
    else
      @page_count = 25
    end
  end

  def array_urls
    total_pages
    @page_count.times do
      @url.to_s.gsub('page=1', "page=#{@number_page}")

      array = Nokogiri::HTML(open(@url)).to_s.scan(REGULAR).map do |url|
        url.gsub('\/', '/')
      end

      @array_urls << array

      @number_page += 1
    end
    puts @array_urls.flatten.length
  end
end
