FactoryBot.define do
  factory :clinic_profile do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    phone { '0987654321' }
    description { Faker::Lorem.sentence(word_count: 20) }
    start_day { 1 }
    end_day { 5 }
    start_hour { Time.now - 10.hour }
    end_hour { Time.now }
  end
end
