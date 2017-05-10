require 'spec_helper'
require 'collection_urls_per_page'

RSpec.describe CollectionUrlsPerPage do
  describe '#run' do
    subject(:collector) { described_class.new(url_base, page_number) }

    let(:url_base) { 'https://ak.api.onliner.by/search/apartments?bounds%5Blb%5D%5Blat%5D=53.6764594639449&bounds%5Blb%5D%5Blong%5D=27.365152809086844&bounds%5Brt%5D%5Blat%5D=54.12722002680655&bounds%5Brt%5D%5Blong%5D=27.759527091732025&currency=USD&metro%5B%5D=red_line&metro' }
    let(:file_path) { 'spec/lib/fixtures/collection_urls_per_page_spec_fixture.html' }
    let(:page_number) { 1 }
    let(:array_urls) {
      [
        'https://r.onliner.by/ak/apartments/226763',
        'https://r.onliner.by/ak/apartments/226071',
        'https://r.onliner.by/ak/apartments/57797',
        'https://r.onliner.by/ak/apartments/226762',
        'https://r.onliner.by/ak/apartments/226761',
        'https://r.onliner.by/ak/apartments/213229',
        'https://r.onliner.by/ak/apartments/226760',
        'https://r.onliner.by/ak/apartments/226759',
        'https://r.onliner.by/ak/apartments/224535',
        'https://r.onliner.by/ak/apartments/226758',
        'https://r.onliner.by/ak/apartments/226034',
        'https://r.onliner.by/ak/apartments/226757',
        'https://r.onliner.by/ak/apartments/213217',
        'https://r.onliner.by/ak/apartments/186001',
        'https://r.onliner.by/ak/apartments/220509',
        'https://r.onliner.by/ak/apartments/220810',
        'https://r.onliner.by/ak/apartments/222477',
        'https://r.onliner.by/ak/apartments/224687',
        'https://r.onliner.by/ak/apartments/225744',
        'https://r.onliner.by/ak/apartments/218990',
        'https://r.onliner.by/ak/apartments/222889',
        'https://r.onliner.by/ak/apartments/225342',
        'https://r.onliner.by/ak/apartments/225823',
        'https://r.onliner.by/ak/apartments/225834',
        'https://r.onliner.by/ak/apartments/78801',
        'https://r.onliner.by/ak/apartments/226756',
        'https://r.onliner.by/ak/apartments/226420',
        'https://r.onliner.by/ak/apartments/90904',
        'https://r.onliner.by/ak/apartments/226755',
        'https://r.onliner.by/ak/apartments/221823',
        'https://r.onliner.by/ak/apartments/225610',
        'https://r.onliner.by/ak/apartments/226754',
        'https://r.onliner.by/ak/apartments/226753',
        'https://r.onliner.by/ak/apartments/226064',
        'https://r.onliner.by/ak/apartments/225344',
        'https://r.onliner.by/ak/apartments/226752'
      ]
    }

    before { allow(Net::HTTP).to receive(:get).and_return(File.read(file_path)) }

    context 'get array urls from page at URL' do
      it 'correct array' do
        expect(collector.call).to eq(array_urls)
      end
    end
  end
end
