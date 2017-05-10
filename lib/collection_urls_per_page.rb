require 'nokogiri'
require 'net/http'
require 'json'

class CollectionUrlsPerPage

  APARTMENTS = "apartments".freeze
  URL_PER_PAGE = "url".freeze

  attr_reader :url, :page_number, :array_urls

  def initialize(url_base, page_number = 1)
    @url = url_base
    @page_number = page_number
  end

  def call
    @array_urls ||= begin
      JSON(Nokogiri::HTML(Net::HTTP.get(URI(url_builder))))[APARTMENTS].map do |link|
        link[URL_PER_PAGE]
      end
    end
  end

  private

  def url_builder
    url.gsub('page=1', "page=#{page_number}")
  end
end
