require './models/order'

describe Order do
  subject { Order.new material, discount }
  let(:material) { double :material }
  let(:standard_delivery) { double :standard_delivery, price: 10 }
  let(:express_delivery) { double :express_delivery, price: 20, name: :express}
  let(:broadcaster_1) { double :broadcaster_1 }
  let(:broadcaster_2) { double :broadcaster_2 }
  let(:discount) { double :discount }


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
      allow(discount).to receive(:update_price).and_return 36
      order = Order.new(material)
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery
      expect{order.add_new_discount(discount)}.not_to raise_error
      expect(order.final_price).to eq(36)
    end

    it 'or a discount may be removed from an order' do
      allow(discount).to receive(:update_price).and_return 40
      subject.add broadcaster_1, express_delivery
      subject.add broadcaster_2, express_delivery
      expect{subject.remove_discount}.not_to raise_error
      expect(subject.final_price).to eq(40)
    end

    it 'unless a discount already exists' do
      allow(discount).to receive(:error_msg).and_return 'Discount Already Exists'
      expect{subject.add_new_discount(discount)}.to raise_error('Discount Already Exists')
    end

    it 'displays a given discount message' do
      allow(discount).to receive(:msg).and_return "Veteran's Discount"
      expect(subject.discount_msg).to eq("Veteran's Discount\n")
    end

    it 'outputs all the order data' do
      allow(material).to receive(:identifier).and_return "HON/TEST001/010"
      allow(discount).to receive(:msg).and_return "Veteran's Discount"
      allow(discount).to receive(:update_price).and_return 40
      expect(subject.output).to include("HON/TEST001/010")
      expect(subject.output).to include("Veteran's Discount")
      expect(subject.output).to include('40')
    end

  end

end
