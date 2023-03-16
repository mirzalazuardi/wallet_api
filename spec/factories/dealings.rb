FactoryBot.define do
  factory :dealing do
    wallet { nil }
    source_wallet_id { 1 }
    target_wallet_id { 1 }
    amount { 1.5 }
    type { "" }
  end
end
