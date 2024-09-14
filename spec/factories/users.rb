FactoryBot.define do
  factory :user do
    username { "test" }
    email { "test1@test.com" }
    password { BCrypt::Password.create("password") }
  end
end
