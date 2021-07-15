class LogOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address_line1, :address_line2, :phone_number, :log_id, :user_id, :item_id

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :address_line1
    validates :phone_number
    validates :user_id
    validates :item_id
  end

  with_options numericality: { other_than: 1, message: "can't be blank"} do
    validates :prefecture_id
  end

  def save
    log = Log.create(user_id: user_id, item_id: item_id)
    Order.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_line1: address_line1, address_line2: address_line2, phone_number: phone_number, log_id: log.id)
  end

end