FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '662001' }
    confirmed_at { Time.current }
  end
end
