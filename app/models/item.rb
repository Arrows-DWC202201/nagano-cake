class Item < ApplicationRecord

  attachment :image

  enum is_active: { 販売中: true, 販売停止中: false }

  def tax_price
    (self.price * 1.10).round
  end

end
