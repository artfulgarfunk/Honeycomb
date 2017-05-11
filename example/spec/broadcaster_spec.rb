require './models/broadcaster'

describe Broadcaster do
  subject { described_class.new 1,'fruitcake'}
  it 'stores the id of the broadcaster' do
    expect(subject.id).to eq(1)
  end

  it 'and stores the name' do
    expect(subject.name).to eq('fruitcake')
  end

end
