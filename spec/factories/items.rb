FactoryBot.define do
  factory :item do
    name {Faker::Lorem.sentence}
    description {Faker::Lorem.sentence}
    category_id {Faker::Number.between(from: 2, to: 12)}
    condition_id {Faker::Number.between(from: 2, to: 7)}
    shipping_fee_id {Faker::Number.between(from: 2, to: 3)}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    shipment_date_id {Faker::Number.between(from: 2, to: 4)}
    price {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/dammychan.png'), filename: 'dammychan.png')
    end
  end
end
