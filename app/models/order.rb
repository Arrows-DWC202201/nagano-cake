class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum order_status: { wating_payment: 0, confirm_payment: 1, making: 2, ready_to_ship: 3, sent: 4 }

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :carriage, presence: true
  validates :total_payment, presence: true

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

end
