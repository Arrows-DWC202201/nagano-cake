class Item < ApplicationRecord

  belongs_to :genre

  attachment :image

  # validates :is_active, inclusion: [true, false]

  enum is_active: { sale: true, sold: false }

  def with_tax_price
    (self.price * 1.10).round
  end

end
