require 'optparse'
require 'ostruct'
require 'pry'
require 'active_support/core_ext/hash'
require 'nokogiri'
require 'open-uri'

class ParserToUrl

  URL = 'https://r.onliner.by/ak/?'.freeze

  attr_reader :options

  def out_url(args)
    puts @options = URL + args.to_query
  end
end
