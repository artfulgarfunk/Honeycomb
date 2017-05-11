require './models/material'

describe Material do
  subject { described_class.new 'fruitcake'}
  it 'stores the name of the material' do
    expect(subject.identifier).to eq('fruitcake')
  end
end
