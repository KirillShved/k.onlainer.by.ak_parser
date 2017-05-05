require 'spec_helper'
require 'persist/json_persist'
require 'json'
require 'fileutils'

RSpec.describe JsonPersist do
  describe '#persist' do
    subject(:saver) { described_class.new(data, path) }

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
