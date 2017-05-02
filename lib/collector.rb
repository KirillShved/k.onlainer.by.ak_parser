require 'nokogiri'
require 'open-uri'
require 'pry'

class Collector

  PRICE_BYN = 'span.apartment-bar__price-value_primary'.freeze
  PRICE_USD = 'span.apartment-bar__price-value_complementary'.freeze
  FLAT = 'span.apartment-bar__value'.freeze
  OWNER = 'span.apartment-bar__value'.freeze
  PHONE_NUMBER = 'div.apartment-info__sub-line'.freeze
  OWNER_NAME = 'div.apartment-info__sub-line_extended'.freeze
  APARTMENT_ALL_ELEMENTS = 'div.apartment-options__item'.freeze
  APARTMENT_ENABLED_ELEMENTS = 'div.apartment-options__item_lack'.freeze
  APARTMENT_INFO_TEXT = 'div.apartment-info__sub-line'.freeze
  APARTMENT_ADDRESS = 'div.apartment-info__sub-line'.freeze

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
      page = Nokogiri::HTML(open(url))

      options_per_url = {
          price_byn:  '',
          price_usd: '',
          flat: '',
          owner: '',
          phone_number: '',
          owner_name: '',
          apartment_address: '',
          enabled_elements: '',
          disabled_elements: '',
          apartment_info_text: ''
      }
      options_per_url[:price_byn] = page.css(PRICE_BYN).text.strip
      options_per_url[:price_usd] = page.css(PRICE_USD).text.strip
      options_per_url[:flat] = page.css(FLAT)[0].text.strip
      options_per_url[:owner] = page.css(OWNER)[1].text.strip
      options_per_url[:phone_number] = page.css(PHONE_NUMBER)[0].text.gsub(" ", "").gsub("\n", " ").strip
      options_per_url[:owner_name] = page.css(OWNER_NAME)[2].text.strip
      options_per_url[:apartment_info_text] = page.css(APARTMENT_INFO_TEXT)[4].text.gsub("\n", " ").strip
      options_per_url[:apartment_address] = page.css(APARTMENT_ADDRESS)[5].text.strip

      features_elements = page.css(APARTMENT_ALL_ELEMENTS)
      all_elements = features_elements.map(&:text)
      enabled_elements_to_s = all_elements - features_elements.css(APARTMENT_ENABLED_ELEMENTS).map(&:text)
      options_per_url[:enabled_elements] = enabled_elements_to_s.join(', ')
      disabled_elements_to_s = all_elements - enabled_elements_to_s
      options_per_url[:disabled_elements] = disabled_elements_to_s.join(', ')
      options_per_url
    end
  end
end
