class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items, :discount

  def initialize(material, discount = false)
    self.material = material
    self.items = []
    self.discount = discount
    @deliveries = []
  end

  def final_price
    self.discount ? discount_price : total_cost
  end

  def discount_price
    items.each { |x| @deliveries << x[1].name }
    self.discount.update_price(@deliveries, total_cost)
  end

  def add_new_discount(discount)
    self.discount ? raise("#{self.discount.error_msg}") : self.discount = discount
  end

  def remove_discount
    self.discount = false
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
      result << "#{discount_msg}Total: $#{final_price}"
    end.join("\n")
  end

  def discount_msg
    self.discount ? "#{self.discount.msg}\n": nil
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
