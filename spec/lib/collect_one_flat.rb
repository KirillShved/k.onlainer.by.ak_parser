require 'spec_helper'
require 'collect_one_flat'

RSpec.describe CollectOneFlat do
  describe '#call' do
    subject(:builder) { described_class.new(url) }

    # +

    let(:path) { 'storage/test_result.json' }
    let(:data) { { "a" => "b", "c" => "d" } }
    let(:conversion) { JSON.parse(File.open(path).read) }

    after(:each) do
      FileUtils.rm_f(path)
    end

    context 'save to file' do

      it 'creates file with content' do
        saver.persist
        expect(File).to exist(path)
        expect(conversion).to eq(data)
      end
    end
  end
end
