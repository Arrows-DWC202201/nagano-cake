class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy


  enum is_active: { active: true, out: false }

  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number, presence: true

end
