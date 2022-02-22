class Item < ApplicationRecord

  has_many :order_items, dependent: :destroy
  belongs_to :genre

  has_many :cart_items, dependent: :destroy

  attachment :image

  enum is_active: { sale: true, sold: false }

  def with_tax_price
    (self.price * 1.10).round
  end

end
