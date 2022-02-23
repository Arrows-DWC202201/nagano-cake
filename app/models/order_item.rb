class OrderItem < ApplicationRecord

  after_update :check_make_status

  belongs_to :order
  belongs_to :item

  enum make_status: {
    impossible: 0,
    waiting:    1,
    making:     2,
    finish:     3
  }

  def subtotal
    (self.tax_price * self.quantity).round
  end

  private

  def check_make_status
    if self.make_status == "making"
      self.order.update(order_status: "making")
    elsif self.make_status == "finish"
      if self.order.order_items.all? { |order_item| order_item.make_status == "finish" }
        self.order.update(ordesr_status: "ready_to_ship")
      end
    end
  end

end
