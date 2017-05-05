require 'spec_helper'
require 'persist/csv_persist'
require 'json'

RSpec.describe CsvPersist do
  describe '#persist' do
    subject(:saver) { described_class.new(data, path) }

    let(:path) { 'storage/test_result.csv' }
    let(:data) { [{ price_byn: 100 }] }
    let(:conversion) do
      CSV.parse(File.open(path).read)[1].map{ |a| Hash[TRANSLATIONS.keys, a] }
    end

    TRANSLATIONS = {
        price_byn:  'Цена: BYN',
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

          binding.pry

        expect(conversion).to eq(data)
      end
    end
  end
end
