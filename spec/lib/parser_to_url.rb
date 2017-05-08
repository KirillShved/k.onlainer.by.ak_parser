require 'spec_helper'
require 'parser_to_url'

RSpec.describe ParserToUrl do
  describe '#call' do
    subject(:collector) { described_class.new(array_urls) }

    context 'get hashes from page at URLS' do

      it 'correct hashes' do
        expect(collector.call).to eq(array_hashes)
      end
    end
  end
end
