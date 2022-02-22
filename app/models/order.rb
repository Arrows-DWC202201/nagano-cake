class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum order_status: {
    wating_payment: 0,
    confirm_payment: 1,
    making: 2,
    ready_to_ship: 3,
    sent: 4
  }



end
