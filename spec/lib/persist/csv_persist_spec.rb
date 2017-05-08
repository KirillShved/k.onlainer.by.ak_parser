require 'spec_helper'
require 'persist/csv_persist'
require 'json'

RSpec.describe CsvPersist do
  describe '#persist' do
    subject(:saver) { described_class.new(data, path) }

    let(:path) { 'storage/test_result.csv' }
    let(:data) {
      [
        {
          price_byn: '100',
          price_usd: '50',
          flat: 'X-Комнатная',
          owner: 'Собственник',
          phone_number: 'Моб. номер',
          owner_name: 'Контактное имя',
          apartment_address: 'Адрес'
        }
      ]
    }
    let(:conversion) do
      a = CSV.parse(File.open(path).read)
      a.shift
      b = a.flatten
      c = b.compact
      i = -1

      result = c.map do |arg|
        Hash[TRANSLATIONS.keys[i += 1], arg]
      end.reduce(&:merge)
      [] << result
    end

    TRANSLATIONS = {
      price_byn:  'Цена: BYN',
      price_usd: 'Цена: USD',
      flat: 'X-Комнатная',
      owner: 'Собственник',
      phone_number: 'Моб. номер',
      owner_name: 'Контактное имя',
      apartment_address: 'Адрес'
    }.freeze

    context 'save to file' do

      after(:each) do
        FileUtils.rm_f(path)
      end

      it 'creates file' do
        saver.persist
        expect(File).to exist(path)
      end

      it 'with content' do
        saver.persist
        expect(conversion).to eq(data)
      end
    end
  end
end
