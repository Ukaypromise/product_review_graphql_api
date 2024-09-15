FactoryBot.define do
  factory :comment do
    body { "MyText" }
    product { nil }
    user { nil }
  end
end
