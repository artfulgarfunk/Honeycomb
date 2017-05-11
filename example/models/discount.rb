class Discount
   attr_reader :msg, :error_msg, :price_point, :delivery, :count, :delivery_reduction, :percent

  def initialize(args = {})
    @price_point = args[:price_point] || 30
    @delivery = args[:delivery] || :express
    @count = args[:count] || 2
    @delivery_reduction = args[:delivery_reduction] || 5
    @percent = args[:percent] || 10
    @error_msg = args[:error_msg] || 'Discount Already Exists'
    @msg = args[:msg] || 'Customer Discount Applied'
    @percent_remain = (100.to_f - @percent) / 100
  end

  def final_price(deliveries, cost)
    (deliveries.count(@delivery) > @count) ? reduce_per(reduce_del(cost,deliveries)) : reduce_per(cost)
  end

  def reduce_del(cost,deliveries)
    (cost - (deliveries.count(@delivery) * @delivery_reduction))
  end

  def reduce_per(cost)
    cost > @price_point ? (cost * @percent_remain) : cost
  end

end
