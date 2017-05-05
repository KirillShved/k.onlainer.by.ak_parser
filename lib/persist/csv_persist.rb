require_relative 'base'
require_relative '../collect_one_flat'
require 'pry'
require 'csv'

class CsvPersist < Base

  TRANSLATIONS = {
      price_byn:  'Цена: BYN',
      price_usd: 'Цена: USD',
      flat: 'X-Комнатная',
      owner: 'Собственник',
      phone_number: 'Моб. номер',
      owner_name: 'Контактное имя',
      apartment_address: 'Адрес',
      **CollectOneFlat::FEATURES_MAPPING.invert,
      apartment_info_text: 'Информация по квартире'
  }.freeze

  attr_reader :data, :path

  def initialize(data, path = 'storage/result.csv')
    @data = data
    @path = path
  end

  def persist
    CSV.open(path, 'w+') do |csv|
      csv << TRANSLATIONS.values
      data.each do |h|
        csv << h.values_at(*TRANSLATIONS.keys)
      end
    end
  end
end
