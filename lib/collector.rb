require_relative 'collect_one_flat'
require 'pry'

class Collector

  attr_reader :urls

  def initialize(array_urls = [])
    @urls = array_urls
  end

  def call
    collects
  end

  private

  def collects
    urls.map do |url|
      CollectOneFlat.new(url).collect_params
    end
  end
end
