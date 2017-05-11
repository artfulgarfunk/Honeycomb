require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

describe Discount do
  subject { Discount.new }
  deliveries = [:express, :express, :express]
  cost = 60
  # let(:deliveries) { double :deliveries}
  # let(:cost) { double :cost }

  it 'can be initialized with various parameters' do
    settings = {  :price_point => 40,
      :delivery => :standard,
      :count => 3,
      :delivery_reduction => 8,
      :percent => 15
    }
    discount = Discount.new(settings)
    expect(discount.price_point).to eq(40)
    expect(discount.delivery).to eq(:standard)
    expect(discount.count).to eq(3)
    expect(discount.delivery_reduction).to eq(8)
    expect(discount.percent).to eq(15)
  end

  it 'is initialized with default values in the absence of given parameters' do
    expect(subject.price_point).to eq(30)
    expect(subject.delivery).to eq(:express)
    expect(subject.count).to eq(2)
    expect(subject.delivery_reduction).to eq(5)
    expect(subject.percent).to eq(10)
  end

  it 'determines the amount to discount from an order and returns the new cost' do
    expect(subject.update_price(deliveries,cost)).to eq(40.5)
  end

  it 'by reducing the delivery cost based on what type of deliveries' do
    expect(subject.reduce_del(cost,deliveries)).to eq(45)
  end

  it 'and by reducing a percentage above a given order cost' do
    discount = Discount.new({:price_point => 40, :percent => 15})
    expect(discount.reduce_per(100)).to eq(85)
  end

end
