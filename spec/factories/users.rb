FactoryBot.define do
  factory :user do
    email { "user@mail.app" }
    password { "valid_password" }
  end
end
