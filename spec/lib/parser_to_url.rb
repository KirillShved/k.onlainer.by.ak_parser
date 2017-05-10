require 'spec_helper'
require 'parser_to_url'

RSpec.describe ParserToUrl do
  describe '#call' do
    subject(:parser) { described_class.new(hash_params) }

    let(:hash_params) do
      {
        rent_type: [
          'room',
          '1_room',
          '2_rooms',
          '3_rooms',
          '4_rooms',
          '5_rooms',
          '6_rooms'
        ],
        currency: 'USD',
        price: {
          min: 50,
          max: 8500
        },
        only_owner: true,
        metro: [
          'red_line',
          'blue_line'
        ],
        bounds: {
          lb: {
            lat:  53.6764594639449,
            long: 27.365152809086844
          },
          rt: {
            lat:  54.12722002680655,
            long: 27.759527091732025
          }
        },
        page: 1,
        type: 'json'
      }.freeze
    end

    let(:array_urls) do [
      "data", "data", "data", "data", "data",
      "data", "data", "data", "data", "data",
      "data", "data", "data", "data", "data",
      "data", "data", "data", "data"
    ]
    end

    before do
      allow_any_instance_of(CollectionUrlsPerPage).to receive(:call).and_return(['data'])
    end

    context 'get array urls from page at URLS' do
      it 'correct array urls' do
        expect(parser.call).to eq(array_urls)
      end
    end
  end
end
