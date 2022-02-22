class Item < ApplicationRecord

  has_many :order_items, dependent: :destroy
  belongs_to :genre

  attachment :image

  enum is_active: { sale: true, sold: false }

  def with_tax_price
    (self.price * 1.10).round
  end

end
