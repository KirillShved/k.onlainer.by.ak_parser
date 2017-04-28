require '../spec_helper.rb'
require '../../lib/collector'

RSpec.describe Solution do
  describe '#mul' do
    subject(:mul) { described_class.new(sym) }

    let(:sym) { 2 }

    it 'main the problem'
    expect(mul).to eq(4)
  end
end
