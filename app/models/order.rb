class Order < ApplicationRecord

  after_update :check_order_item

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum order_status: { wating_payment: 0, confirm_payment: 1, making: 2, ready_to_ship: 3, sent: 4 }

  def set_receiver(receiver)
    self.address = receiver.address
    self.postal_code = receiver.postal_code
    if receiver.is_a?(Customer)
      self.name = receiver.full_name.gsub(" ", "")
    else
      self.name = receiver.name
    end
  end

  def order_items_total_price
    (total_payment - 800).round
  end

  def order_items_total_quantity
    self.order_items.sum(:quantity)
  end

  after_create :move_cart_items
  after_update :check_order_item

  private

  def move_cart_items
    cart_items_list = self.customer.cart_items.map do |cart_item|
      {
        item_id: cart_item.item_id,
        tax_price: cart_item.item.with_tax_price,
        quantity: cart_item.quantity
      }
    end
    self.order_items.create(cart_items_list)
    self.customer.cart_items.destroy_all
  end

  def check_order_item
    if self.order_status == "confirm_payment"
      self.order_items.update_all(make_status: "wating")
    end
  end

end
