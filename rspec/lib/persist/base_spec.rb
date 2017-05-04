require_relative '../../spec_helper'
require_relative '../../../lib/persist/base'

describe Base do
  describe '#persist' do
    context 'base method persist' do
      it { expect { Base.new.persist }.to raise_error(NotImplementedError) }
    end
  end
end
