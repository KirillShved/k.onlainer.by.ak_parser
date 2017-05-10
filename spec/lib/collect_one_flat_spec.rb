require 'spec_helper'
require 'collect_one_flat'

RSpec.describe CollectOneFlat do
  describe '#call' do
    subject(:builder) { described_class.new(url) }

    let(:url) { 'https://r.onliner.by/ak/apartments/217556' }
    let(:file_path) { 'spec/lib/fixtures/collect_one_flat_spec_fixture.html' }
    let(:hash) {
      {
        :air_conditioning => true,
        :apartment_address => "Минск, проспект Дзержинского 119",
        :apartment_info_text => "Новая однокомнатная квартира 51 кв. м. на длительный срок. Проспект Дзержинского 119. 18-тый этаж 24-хэтажного дома. Рядом сквер, пруд. Метро Малиновка возле дома. Большая лоджия 10.3 кв.м. с панорамными окнами. Кухня 12 кв. м., натяжные потолки, пол ламинат, плитка. С/у раздельный, Кондиционер. Гардеробная. Большой коридор. На кухне мебель, стиральная машинка, холодильник, вытяжка, духовка, плита стеклокерамика. Всё новое. Оплата + счётчики. Предоплата 2 месяца. Без детей и животных.",
        :balcony => true,
        :flat => "1-комнатная квартира",
        :furniture => false,
        :internet => true,
        :kitchen => true,
        :machine => true,
        :oven => true,
        :owner => "Собственник",
        :owner_name => "Лариса",
        :phone_number => "+37525905-71-50",
        :price_byn => "583,54 р.",
        :price_usd => "310 $",
        :refrigerator => true,
        :tv => false,
      }
    }

    before { allow(Net::HTTP).to receive(:get).and_return(File.read(file_path)) }

    context 'get hash from page at URL' do
      it 'get correct hash' do
        expect(builder.call).to eq(hash)
      end
    end
  end
end
