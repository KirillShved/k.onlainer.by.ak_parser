require 'active_support/core_ext/hash'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'pry'
require 'optparse'
require 'ostruct'

class CollectorInfo

  PRICE_BYN = 'span.apartment-bar__price-value_primary'.freeze #+
  PRICE_USD = 'span.apartment-bar__price-value_complementary'.freeze #+
  FLAT = 'span.apartment-bar__value'.freeze #+
  OWNER = 'span.apartment-bar__value'.freeze #+
  PHONE_NUMBER = 'div.apartment-info__sub-line'.freeze #+
  OWNER_NAME = 'div.apartment-info__sub-line_extended'.freeze #+
  APARTMENT_INFO = 'span.apartment-bar__price-value_primary'.freeze
  APARTMENT_INFO_TEXT = 'div.apartment-info__sub-line'.freeze #+
  APARTMENT_ADDRESS = 'div.apartment-info__sub-line'.freeze

  attr_reader :array_urls, :one_url

  def initialize(array_urls = [])
    @array_urls = array_urls
    @one_url = array_urls.first
  end

  def call
    collects
  end

  private

  def collects
    puts @one_url = array_urls.first
    page = Nokogiri::HTML(open(@one_url))

    price_byn = page.css(PRICE_BYN).text.strip
    price_usd = page.css(PRICE_USD).text.strip
    flat = page.css(FLAT)[0].text.strip
    owner = page.css(OWNER)[1].text.strip
    phone_number = page.css(PHONE_NUMBER)[0].text.strip
    owner_name = page.css(OWNER_NAME)[2].text.strip
    apartment_info = page.css(APARTMENT_INFO).text.strip
    apartment_info_text = page.css(APARTMENT_INFO_TEXT)[4].text.strip
    apartment_address = page.css(APARTMENT_ADDRESS)[5].text.strip

    all_flat_info = [
        price_byn,
        price_usd,
        flat,
        owner,
        phone_number,
        owner_name,
        apartment_info,
        apartment_info_text,
        apartment_address
    ]

    puts all_flat_info
    all_flat_info
  end
end
