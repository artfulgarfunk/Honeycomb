require './models/delivery'

describe Delivery do
  subject { described_class.new 'fruitcake',17}
  it 'stores the name of the delivery' do
    expect(subject.name).to eq('fruitcake')
  end

  it 'and stores the price' do
    expect(subject.price).to eq(17)
  end

end
