require 'nokogiri'
require 'open-uri'

class CollectOneFlat

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
  FEATURES_MAPPING = {
    'Мебель' => :furniture,
    'Кухонная мебель' => :kitchen,
    'Плита' => :oven,
    'Холодильник' => :refrigerator,
    'Стиральная машина' => :machine,
    'Телевизор' => :tv,
    'Интернет' => :internet,
    'Лоджия или балкон' => :balcony,
    'Кондиционер' => :air_conditioning
  }.freeze

  attr_reader :page

  def initialize(url)
    @page = Nokogiri::HTML(open(url))
  end

  def call
    {
      price_byn:  price_byn,
      price_usd: price_usd,
      flat: flat,
      owner: owner,
      phone_number: phone_number,
      owner_name: owner_name,
      apartment_address: apartment_address,
      **features,
      apartment_info_text: apartment_info_text
    }
  end

  private

  def price_byn
    page.css(PRICE_BYN).text.strip
  end

  def price_usd
    page.css(PRICE_USD).text.strip
  end

  def flat
    page.css(FLAT)[0].text.strip
  end

  def owner
    page.css(OWNER)[1].text.strip
  end

  def phone_number
    page.css(PHONE_NUMBER)[0].text.gsub(" ", "").gsub("\n", " ").strip
  end

  def owner_name
    page.css(OWNER_NAME)[2].text.strip
  end

  def apartment_address
    page.css(APARTMENT_ADDRESS)[5].text.strip
  end

  def features
    features_elements = page.css(APARTMENT_ALL_ELEMENTS)
    all_elements = features_elements.map(&:text)
    enabled_elements = all_elements - features_elements.css(APARTMENT_ENABLED_ELEMENTS).map(&:text)

    FEATURES_MAPPING.inject({}) do |memo, (key, value)|
      memo[value] = enabled_elements.include?(key)
      memo
    end
  end

  def apartment_info_text
    page.css(APARTMENT_INFO_TEXT)[4].text.gsub("\n", " ").strip
  end
end
