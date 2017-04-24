require 'optparse'
require 'ostruct'
require '../lib/options'
require 'active_support'
require 'pry'

class Parser

  URL = 'https://r.onliner.by/ak/?'.freeze

  attr_reader :options, :url

  def initialize(*arg)
    @options = arg
  end

  def output
    puts @options = OptparseExample.parse(ARGV)

    @url = @options.to_query
  end
end

Parser.new.output
