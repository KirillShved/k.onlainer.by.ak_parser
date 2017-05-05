require_relative '../../../spec/spec_helper'
require_relative '../../../lib/persist/json_persist'
require 'json'

RSpec.describe JsonPersist do
  describe '#persist' do
    subject(:saver) { described_class.new(data, path) }

    let(:path) { 'storage/test_result.json' }
    let(:data) { { "a" => "b", "c" => "d" } }
    let(:conversion) { JSON.parse(File.open(path).read) }

    context 'save to file' do

      it 'file exist' do
        saver.persist
        expect(File).to exist(path)
      end

      it 'the file has contents' do
        saver.persist
        expect(conversion).to eq(data)
      end
    end
  end
end
