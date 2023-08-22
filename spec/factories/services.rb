FactoryBot.define do
  factory :service do
    id { 1 }
    clinic_profile_id { 1 }
    name { 'Service' }
    description { 'Description' }
    price { 5.5 }
    execution_time { 20 }
  end
end
