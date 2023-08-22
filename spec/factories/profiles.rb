FactoryBot.define do
  factory :profile do
    fullname { Faker::Name.name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    address { Faker::Address.full_address }
  end
end
