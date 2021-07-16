class LogOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address_line1, :address_line2, :phone_number, :log_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)'}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank"}
    validates :city
    validates :address_line1
    validates :phone_number, length: { in: 10..11 , message: "is too short"}, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only number" }
    validates :user_id
    validates :item_id
  end

  def save
    log = Log.create(user_id: user_id, item_id: item_id)
    Order.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_line1: address_line1, address_line2: address_line2, phone_number: phone_number, log_id: log.id)
  end

end