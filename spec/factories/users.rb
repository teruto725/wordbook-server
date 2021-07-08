FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com"}
    sequence(:password){"testets"}
  end
end
