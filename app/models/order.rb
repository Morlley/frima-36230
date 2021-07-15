class Order < ApplicationRecord
  belongs_to :log

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :address_line1
    validates :address_line2
    validates :phone_number
  end

  with_options numericality: { other_than: 1, message: "can't be blank"} do
    validates :prefecture_id
  end
end
