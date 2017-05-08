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
          :price_byn => "338,83 р.",
          :price_usd => "180 $",
          :flat => "1-комнатная квартира",
          :owner => "Собственник",
          :phone_number => "+37525620-68-28 +37533328-38-04",
          :owner_name => "Николай",
          :apartment_address => "Размещено 3 месяца назад",
          :furniture => true,
          :kitchen => true,
          :oven => true,
          :refrigerator => true,
          :machine => true,
          :tv => true,
          :internet => false,
          :balcony => false,
          :air_conditioning => false,
          :apartment_info_text => "Минск, улица Тухачевского, 29"
        },
        {
          :price_byn => "376,48 р.",
          :price_usd => "200 $",
          :flat => "1-комнатная квартира",
          :owner => "Собственник",
          :phone_number => "+37529704-15-16 +37529120-00-15",
          :owner_name => "Сергей",
          :apartment_address => "Минск, Алтайская улица, 78 к3",
          :furniture => true,
          :kitchen => true,
          :oven => true,
          :refrigerator => true,
          :machine => true,
          :tv => true,
          :internet => true,
          :balcony => false,
          :air_conditioning => false,
          :apartment_info_text => "Однокомнатная квартира.Все необходимое для проживания есть.Мебель,кухня,телевизор,интернет,стиральная машинка.Метро в 10-и минутах ходьбы."
        },
        {
          :price_byn => "329,42 р.",
          :price_usd => "175 $",
          :flat => "1-комнатная квартира",
          :owner => "Собственник",
          :phone_number => "+37529185-83-74",
          :owner_name => ".",
          :apartment_address => "Минск, улица Якубовского, 26 к4",
          :furniture => false,
          :kitchen => true,
          :oven => true,
          :refrigerator => false,
          :machine => false,
          :tv => false,
          :internet => false,
          :balcony => true,
          :air_conditioning => false,
          :apartment_info_text => "Квартира находится на 7 этаже. Дом в одной остановке от станции метро Кунцевщина. Рядом есть магазины, поликлиника, рынок, хорошее транспортное сообщение. В квартире прописан человек, поэтому коммунальные платежи будут по хорошим тарифам."
        }
      ]
    }

    context 'get hashes from page at URLS' do

      it 'correct hashes' do
        expect(collects.call).to eq(array_hashes)
      end
    end
  end
end
