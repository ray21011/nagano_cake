class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  # belongs_to :genre
  has_many :orders, through: :order_details
def change_price
  (self.price*1.1).floor
end
  # attachment :image
  has_one_attached :image
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
