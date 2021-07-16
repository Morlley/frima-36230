FactoryBot.define do
  factory :log_order do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code { '123-4567' }
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    city {"大阪市"}
    address_line1 {"1-1"}
    address_line2 {"建物名"}
    phone_number {"12345678901"}
  end
end