FactoryBot.define do
  factory :stock_price do
    stock { nil }
    price { 1.5 }
    update_time { "2023-03-15 23:21:31" }
  end
end
