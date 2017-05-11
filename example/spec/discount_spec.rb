require './models/discount'

describe Discount do
  subject { Discount.new }
  deliveries = [:express, :express, :express]
  cost = 60

  it 'can be initialized with various parameters' do
    settings = {  :price_point => 40,
      :delivery => :standard,
      :count => 3,
      :delivery_reduction => 8,
      :percent => 15
    }
    expect{discount = Discount.new(settings)}.to_not raise_error
  end

  it 'is initialized with default values in the absence of given parameters' do
    expect{discount = Discount.new}.to_not raise_error
    discount = Discount.new
    expect{discount.update_price(deliveries,cost)}.to_not raise_error
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

  it "returns an error message 'Discount Already Exists' by default" do
    expect(subject.error_msg).to eq('Discount Already Exists')
  end

  it "which can be defined on discount creation" do
    discount = Discount.new({:error_msg => 'This is an error'})
    expect(discount.error_msg).to eq('This is an error')
  end

  it "has a customisable message in case of displaying discount details etc" do
    discount = Discount.new({:msg => 'Student Discount'})
    expect(discount.msg).to eq('Student Discount')
  end

  it "with a default 'Customer Discount Applied' message" do
    expect(subject.msg).to eq('Customer Discount Applied')
  end

end
