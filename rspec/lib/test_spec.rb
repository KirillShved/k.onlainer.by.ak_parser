require_relative '../spec_helper'

RSpec.describe Test do
  describe '#run' do
    subject(:tester) { described_class.new }
    context 'method_run' do
      it { expect(tester.run).to eq(10) }
    end
  end
end
