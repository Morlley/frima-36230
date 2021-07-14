class Item < ApplicationRecord
  belongs_to :user
  has_one :log
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipment_date

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price, presence: true, format: { with: /\A[1-9]+\z/, message: "is invalid. Input half-width characters"}, inclusion: { in: 300..9_999_999, message: "is out of setting range" }
  end

  with_options numericality: { other_than: 1, message: "can't be blank"} do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipment_date_id
  end

end
