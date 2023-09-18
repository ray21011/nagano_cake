class Order < ApplicationRecord
   VALID_POSTCODE_REGEX = /\A\d{7}\z/

  validates :billing_amount, presence: true
  validates :payment_method, presence: true
  validates :postage, presence: true
  validates :address, length: { in: 1..48 }
  validates :postal_code, format: { with: VALID_POSTCODE_REGEX }
  validates :address_name, length: { in: 1..32 }
  # validates :order_status, presence: true

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :items, through: :order_details

  enum payment_method: {クレジットカード:0, 銀行振込:1}
  enum order_status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}


  #@order.valid?を使用したいための、仮情報入力
  def temporary_information_input(current_customer_id)
    self.customer_id = current_customer_id
    self.postage = 800
    self.billing_amount = 1
  end

  def order_in_postal_code_address_name(postal_code, address, name)
    self.postal_code = postal_code
    self.address = address
    self.address_name = name
  end

end
