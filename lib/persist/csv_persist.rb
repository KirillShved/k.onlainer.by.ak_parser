require_relative 'base'
require 'csv'

class CsvPersist < Base

  TRANSLATIONS = {
      price_byn:  'Цена: BYN',
      price_usd: 'Цена: USD',
      flat: 'Комната',
      owner: 'ф',
      phone_number: 'ф',
      owner_name: 'ф',
      apartment_address: 'ф',
      **CollectOneFlat::FEATURES_MAPPING.invert,
      apartment_info_text: 'ф'
  }.freeze

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def persist
    CSV.open('../storage/output.csv', 'w+') do |csv|
      csv << TRANSLATIONS.values
      data.each do |h|
        csv << h.values_at(*TRANSLATIONS.keys)
      end
    end
  end
end
