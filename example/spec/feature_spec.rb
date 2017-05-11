require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

describe 'Features' do
  let(:material) { Material.new("123/TEST/098") }
  let(:broadcaster) { Broadcaster.new(1,'Viacom')}
  let(:broadcaster) { Broadcaster.new(2,'T-Mobile')}
  let(:delivery) { Delivery.new(:express,30) }
  let(:discount) { Discount.new }
  let(:order) { Order.new(material,discount)}
end
