require '../../spec_helper'
require '../../../lib/persist/json_persist'

RSpec.describe JsonPersist do
  describe '#json_to_hash' do
    subject(:json_persist) { described_class.new(hash) }

    let(:hash) do
      {
          price_byn:  'price_byn',
          price_usd: 'price_usd',
          flat: 'flat',
          owner: 'owner',
          phone_number: 'phone_number',
          owner_name: 'owner_name',
          apartment_address: 'apartment_address',
          apartment_info_text: 'apartment_info_text'
      }
    end

    let(:json) do
      "{\"price_byn\":\"price_byn\",\"price_usd\":\"price_usd\",\"flat\":\"flat\",\"owner\":\"owner\",\"phone_number\":\"phone_number\",\"owner_name\":\"owner_name\",\"apartment_address\":\"apartment_address\",\"apartment_info_text\":\"apartment_info_text\"}"
    end

    context 'hash to json' do
      it { expect(json_persist.hash_to_json).to eq(json) }
    end
  end

  describe 'Check if file exists and is file' do

    let(:file) { '../../../storage/result.json' }
    let(:file_fixture) { 'fixture.json' }

    context 'file exist?' do
      it { expect(File).to exist(file) }
    end

    context 'file include content?' do
      it { expect(File.read(file)).to include(File.read(file_fixture)) }
    end
  end
end
