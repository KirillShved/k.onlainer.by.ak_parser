require 'spec_helper'
require 'collect_one_flat'

RSpec.describe CollectOneFlat do
  describe '#call' do
    subject(:builder) { described_class.new(url) }

    let(:url) { 'https://r.onliner.by/ak/apartments/226191' }
    let(:hash) {
      {
        :air_conditioning => false,
        :apartment_address => "Минск, Кальварийская улица, 52",
        :apartment_info_text => "Развитая инфраструктура: рядом метро \"Пушкинская\", \"Молодёжная\" и ТЦ \"Корона\" (пару минут на транспорте), с мебелью, есть стиральная машина, СВЧ, 2/5 этаж, без балкона, кирпичный дом, прописан 1 человек, на длительный срок.",
        :balcony => false,
        :flat => "1-комнатная квартира",
        :furniture => true,
        :internet => true,
        :kitchen => true,
        :machine => true,
        :oven => true,
        :owner => "Собственник",
        :owner_name => "Эдгар",
        :phone_number => "+37533363-73-38",
        :price_byn => "320,01 р.",
        :price_usd => "170 $",
        :refrigerator => true,
        :tv => true
      }
    }

    context 'get hash from page at URL' do

      it 'get correct hash' do
        expect(builder.call).to eq(hash)
      end
    end
  end
end
