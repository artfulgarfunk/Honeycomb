require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

describe 'Features' do
  let(:material) { Material.new("123/TEST/098") }
  let(:broadcaster_1) { Broadcaster.new(1,'Viacom')}
  let(:broadcaster_2) { Broadcaster.new(2,'Disney')}
  let(:broadcaster_3) { Broadcaster.new(3,'Channel 4')}
  let(:express_delivery) { Delivery.new(:express,20) }
  let(:standard_delivery) { Delivery.new(:standard,10) }
  let(:discount) { Discount.new }
  let(:order) { Order.new(material)}
  settings = {  :price_point => 40,
    :delivery => :standard,
    :count => 3,
    :delivery_reduction => 8,
    :percent => 15,
    :msg => "Veteran's Discount",
    :error_msg => 'Already Discounted!!'
  }

  context 'so that companies can buy products from Honeycomb' do
    it 'a user can add broadcasters to a new order' do
      expect{order.add(broadcaster_1, standard_delivery)}.to_not raise_error
    end

    before do
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery
      order.add broadcaster_3, standard_delivery
    end

    it 'there is no discount by default' do
      expect(order.final_price).to eq(50)
    end

    it 'can add custom discounts to an order' do
      expect{order.add_new_discount(Discount.new(settings))}.to_not raise_error
      expect(order.final_price).to eq(42.5)
    end

    it 'or can remove them' do
      order.add_new_discount(discount)
      expect{order.remove_discount}.to_not raise_error
      expect(order.final_price).to eq(50)
    end

    it 'a user can see the totality of the order, materials, broadcasters, delivery methods and discounts' do
      order.add_new_discount(discount)
      expect{order.output}.to_not raise_error
      expect(order.output).to include(material.identifier)
      expect(order.output).to include(express_delivery.name.to_s)
      expect(order.output).to include(standard_delivery.name.to_s)
      expect(order.output).to include(broadcaster_1.id.to_s)
    end
  end


end
