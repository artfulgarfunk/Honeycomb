require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'

describe Order do
  subject { Order.new material, discount }
  let(:discount) { Discount.new }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }
  broadcaster_1 = Broadcaster.new(1, 'Viacom')
  broadcaster_2 = Broadcaster.new(2, 'Disney')
  # double discount and allow it to recieve x and return y

  context 'when empty' do
    it 'costs nothing' do
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'with items' do
    it 'returns the total cost of all items' do
      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery
      expect(subject.total_cost).to eq(30)
    end

    it 'can be initialized with discount' do
      expect{Order.new(material, discount)}.not_to raise_error
    end

    it 'or without a discount' do
      expect{order = Order.new(material)}.not_to raise_error
    end

    it 'a discount may be added later to an existing order' do
      order = Order.new(material)
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery
      expect(order.final_price).to eq(40)
      expect{order.add_new_discount(discount)}.not_to raise_error
      expect(order.final_price).to eq(36)
    end

    it 'or a discount may be removed from an order' do
      subject.add broadcaster_1, express_delivery
      subject.add broadcaster_2, express_delivery
      expect(subject.final_price).to eq(36)
      expect{subject.remove_discount}.not_to raise_error
      expect(subject.final_price).to eq(40)
    end

    it 'unless a discount already exists' do
      order = Order.new(material,discount)
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery
      expect{order.add_new_discount(discount)}.to raise_error('Discount Already Exists')
    end
  end

end
