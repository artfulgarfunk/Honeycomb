require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

standard_delivery = Delivery.new(:standard, 10.0)
express_delivery = Delivery.new(:express, 20.0)

broadcaster_1 = Broadcaster.new(1, 'Viacom')
broadcaster_2 = Broadcaster.new(2, 'Disney')
broadcaster_3 = Broadcaster.new(3, 'Discovery')
broadcaster_4 = Broadcaster.new(4, 'ITV')
broadcaster_5 = Broadcaster.new(5, 'Channel 4')
broadcaster_6 = Broadcaster.new(6, 'Bike Channel')
broadcaster_7 = Broadcaster.new(7, 'Horse and Country')

material1 = Material.new("WNP/SWCL001/010")

order1 = Order.new(material1,Discount.new)

order1.add broadcaster_2, standard_delivery
order1.add broadcaster_3, standard_delivery
order1.add broadcaster_1, standard_delivery
order1.add broadcaster_7, express_delivery

material2 = Material.new('ZDW/EOWW005/010')

order2 = Order.new(material2,Discount.new)


order2.add broadcaster_2, express_delivery
order2.add broadcaster_3, express_delivery
order2.add broadcaster_1, express_delivery

material3 = Material.new("WNP/WADWAD/SAWSAW")

order3 = Order.new(material3)
order3.add broadcaster_2, express_delivery
order3.add broadcaster_3, express_delivery
order3.add broadcaster_1, express_delivery


material4 = Material.new("WNP/WADWAD/SAWSAW")

order4 = Order.new(material4)
order4.add broadcaster_2, express_delivery
order4.add broadcaster_3, express_delivery
order4.add broadcaster_1, express_delivery
order4.add_new_discount(Discount.new)


print order1.output
print "\n"
print 'Should be 45'
print "\n"
print order2.output
print "\n"
print "Should be 40.50"
print "\n"
print order3.output
print "\n"
print "Should be 60"
print "\n"
print order4.output
print "\n"
print "Should be 40.5"
print "\n"
