class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  enum is_active: { active: true, out: false }

  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number, presence: true

  def full_name
   last_name + " " + first_name
  end

  def full_address
    "〒" + self.postal_code + "  " + self.address + last_name + " " + first_name
  end

  def cart_items_total_price
    sum = 0
    self.cart_items.each { |cart_item| sum += cart_item.subtotal }
    return sum
  end
  # public/orders/controllerで使用

end
