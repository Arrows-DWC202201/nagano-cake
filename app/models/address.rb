class Address < ApplicationRecord
  belongs_to :customer

  validates :customer_id, :postal_code, :address, :name, presence: true
  validates :postal_code, numericality: {only_integer: true}, length: { is: 7 }

end
