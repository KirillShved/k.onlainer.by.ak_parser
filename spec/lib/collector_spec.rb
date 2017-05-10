require 'spec_helper'
require 'collector'

RSpec.describe Collector do
  describe '#call' do
    subject(:collects) { described_class.new(array_urls) }

    let(:array_urls) {
      [
        'https://r.onliner.by/ak/apartments/192497',
        'https://r.onliner.by/ak/apartments/226071',
        'https://r.onliner.by/ak/apartments/147201'
      ]
    }
    let(:array_hashes) {
      [
        {
            :data => "data"
        },
        {
            :data => "data"
        },
        {
            :data => "data"
        }
      ]
    }

    before do
      allow_any_instance_of(CollectOneFlat).to receive(:call).and_return({ :data => "data" })
      allow(Net::HTTP).to receive(:get).and_return(nil)
    end

    context 'get hashes from page at URLS' do
      it 'correct hashes' do
        expect(collects.call).to eq(array_hashes)
      end
    end
  end
end
