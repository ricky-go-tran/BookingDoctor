FactoryBot.define do
  factory :medical_resource do
    name { 'Pracetamol' }
    brand { 'DHG pharmacy' }
    unit { 'Unit' }
    description { 'Sample sample sample' }
    medical_resource_type { 'medicine' }
  end
end
