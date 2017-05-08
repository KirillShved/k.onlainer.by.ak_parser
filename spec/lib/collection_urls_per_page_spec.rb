require 'spec_helper'
require 'collection_urls_per_page'

RSpec.describe CollectionUrlsPerPage do
  describe '#run' do
    subject(:collector) { described_class.new(url_base, page_number) }

    let(:url_base) { 'https://ak.api.onliner.by/search/apartments?bounds%5Blb%5D%5Blat%5D=53.6764594639449&bounds%5Blb%5D%5Blong%5D=27.365152809086844&bounds%5Brt%5D%5Blat%5D=54.12722002680655&bounds%5Brt%5D%5Blong%5D=27.759527091732025&currency=USD&metro%5B%5D=red_line&metro' }
    let(:page_number) { 1 }
    let(:array_urls) {
      [
        'https://r.onliner.by/ak/apartments/221017',
        'https://r.onliner.by/ak/apartments/192497',
        'https://r.onliner.by/ak/apartments/226071',
        'https://r.onliner.by/ak/apartments/147201',
        'https://r.onliner.by/ak/apartments/225753',
        'https://r.onliner.by/ak/apartments/143465',
        'https://r.onliner.by/ak/apartments/225562',
        'https://r.onliner.by/ak/apartments/225371',
        'https://r.onliner.by/ak/apartments/224898',
        'https://r.onliner.by/ak/apartments/224854',
        'https://r.onliner.by/ak/apartments/222808',
        'https://r.onliner.by/ak/apartments/205470',
        'https://r.onliner.by/ak/apartments/222755',
        'https://r.onliner.by/ak/apartments/222356',
        'https://r.onliner.by/ak/apartments/220591',
        'https://r.onliner.by/ak/apartments/217706',
        'https://r.onliner.by/ak/apartments/219086',
        'https://r.onliner.by/ak/apartments/138868'
      ]
    }

    context 'get array urls from page at URL' do

      it 'correct array' do
        expect(collector.run).to eq(array_urls)
      end
    end
  end
end
