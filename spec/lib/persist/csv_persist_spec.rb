require 'spec_helper'
require 'persist/csv_persist'
require 'json'

RSpec.describe CsvPersist do
  describe '#persist' do
    subject(:saver) { described_class.new(data, path) }

    let(:path) { 'storage/test_result.csv' }
    let(:path_fake_file) { 'storage/test_result_v2.csv' }
    let(:fake_file) { CSV.parse(File.open(path_fake_file).read) }
    let(:exist_file) { CSV.parse(File.open(path).read) }
    let(:data) {
      [
        {
          price_byn: '100',
          price_usd: '50',
          flat: 'X-Комнатная',
          owner: 'Собственник',
          phone_number: '+375 29 111 11 11',
          owner_name: 'Юра',
          apartment_address: 'Супер! Адрес'
        }
      ]
    }
    let(:conversion) { [] << Hash[TRANSLATIONS.keys.zip exist_file.drop(1).flatten] }

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

      it 'and persist file eq result' do
        saver.persist
        expect(fake_file).to eq(exist_file)
      end
    end
  end
end
