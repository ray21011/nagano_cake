class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  # belongs_to :genre
  has_many :orders, through: :order_details
def change_price(without_tax_price)
  without_tax_price*1.10
end
  # attachment :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
end
