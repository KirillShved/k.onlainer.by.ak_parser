require_relative 'repository'

class CollectorInfo

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

  attr_reader :array_urls, :one_url

  def initialize(array_urls = [])
    @array_urls = array_urls
    @one_url = array_urls.first
  end

  def call
    Repository.new(collects).call
  end

  private

  def collects
    page = Nokogiri::HTML(open(@one_url))

    all_flat_info = {
        price_byn:  '',
        price_usd: '',
        flat: '',
        owner: '',
        phone_number: '',
        owner_name: '',
        apartment_info_text: '',
        apartment_address: '',
        enabled_elements: '',
        disabled_elements: ''
    }

    all_flat_info[:price_byn] = page.css(PRICE_BYN).text.strip
    all_flat_info[:price_usd] = page.css(PRICE_USD).text.strip
    all_flat_info[:flat] = page.css(FLAT)[0].text.strip
    all_flat_info[:owner] = page.css(OWNER)[1].text.strip
    all_flat_info[:phone_number] = page.css(PHONE_NUMBER)[0].text.strip
    all_flat_info[:owner_name] = page.css(OWNER_NAME)[2].text.strip
    all_flat_info[:apartment_info_text] = page.css(APARTMENT_INFO_TEXT)[4].text.strip
    all_flat_info[:apartment_address] = page.css(APARTMENT_ADDRESS)[5].text.strip

    features_elements = page.css(APARTMENT_ALL_ELEMENTS)
    all_elements = features_elements.map(&:text)

    all_flat_info[:enabled_elements] = all_elements - features_elements.css(APARTMENT_ENABLED_ELEMENTS).map(&:text)
    all_flat_info[:disabled_elements] = all_elements - all_flat_info[:enabled_elements]

    all_flat_info
  end
end
