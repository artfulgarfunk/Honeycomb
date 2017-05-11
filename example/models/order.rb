class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items

  def initialize(material, discount = false)
    self.material = material
    self.items = []
    @discount = discount
    @deliveries = []
  end

  def final_price
    @discount ? discount_price : total_cost
  end

  def discount_price
    items.each { |x| @deliveries << x[1].name }
    @discount.update_price(@deliveries, total_cost)
  end

  def add_new_discount(discount)
    @discount = discount
  end

  def remove_discount
    @discount = false
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def total_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{final_price}"
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end

  # add discount method: takes a an entire object
end
