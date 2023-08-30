
ActiveRecord::Base.transaction do
  # Create role admin
  admin = User.create!(email: 'admin.study@gmail.com', password: '662001', confirmed_at: Time.current)
  admin.delete_roles
  admin.add_role :admin
  admin_profile =  Profile.create!(fullname: Faker::Lorem.sentence, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), address: Faker::Address.full_address, user_id: admin.id)
  # Create role patient
  patient = User.create!(email: 'patient.study@gmail.com', password: '662001', confirmed_at: Time.current)
  patient.add_role :patient
  patient1 = User.create!(email: 'trandaiphat046@gmail.com', password: '662001', confirmed_at: Time.current)
  patient1.add_role :patient
  patient_profile = Profile.create!(fullname: Faker::Lorem.sentence, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), address: Faker::Address.full_address, user_id: patient.id)
  patient_profile1 = Profile.create!(fullname: Faker::Lorem.sentence, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), address: Faker::Address.full_address, user_id: patient1.id)
  patient_specification_profile = PatientProfile.create!(profile_id: patient_profile.id)
  patient_specification_profile1 = PatientProfile.create!(profile_id: patient_profile1.id)

  # Create role clinic
  clinic_user = []
  5.times do
    clinic = User.create!(email: Faker::Internet.email, password: '662001', confirmed_at: Time.current)
    clinic.delete_roles
    clinic.add_role :clinic
    clinic_user.push(clinic)
  end
  clinic4 = User.create!(email: 'ricky.tran.goldenowl@gmail.com', password: '662001', confirmed_at: Time.current)
  clinic4.delete_roles
  clinic4.add_role :clinic
  clinic_user.push(clinic4)

  clinic_profiles = []
  clinic_user.each do |clinic|
    clinic_profile = Profile.create!(fullname: Faker::Lorem.sentence, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), address: Faker::Address.full_address, user_id: clinic.id)
    clinic_profiles.push(clinic_profile)
  end

  category_dental = Category.create!(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10))
  category_pediatric = Category.create!(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10))
  category_dermatology = Category.create!(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10))

  # Create clinic specification
  clinic_specification_profiles = []
  clinic_profiles.each do |clinic_profile|
    clinic_specification_profile = ClinicProfile.new(name: Faker::Lorem.sentence, address: Faker::Address.full_address, profile_id: clinic_profile.id, description: Faker::Lorem.paragraph(sentence_count: 10), start_hour: "00:00:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
    clinic_specification_profile.certificate.attach(io: URI.open(Faker::LoremFlickr.image(size: "1200x900")), filename: 'default.jpg')
    clinic_specification_profile.clinic_view.attach(io: URI.open(Faker::LoremFlickr.image(size: "1200x900")), filename: 'default.jpg')
    clinic_specification_profile.save!
    clinic_specification_profiles.push(clinic_specification_profile)
  end

  # Create service
  service_clinic = []
  clinic_specification_profiles.each do |clinic_specification_profile|
    8.times do
      service = Service.new(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10) , price: Faker::Number.within(range: 1..5), execution_time: Faker::Number.within(range: 50..60), clinic_profile_id: clinic_specification_profile.id)
      service.service_wallpaper.attach(io: URI.open(Faker::LoremFlickr.image(size: "1200x900")), filename: 'default.jpg')
      service.save!
      service_clinic.push(service)
    end
  end
# Create medical resources
  medical_resources = []
  30.times do
    medical_resource = MedicalResource.create!(name:  Faker::Lorem.sentence, brand: Faker::Lorem.sentence, unit: "PCS", description: Faker::Lorem.paragraph(sentence_count: 10), medical_resource_type: "medicine")
    medical_resources.push(medical_resource)
  end

  # Create inventories
  inventories = []
  clinic_specification_profiles.each do |clinic_specification_profile|
    medical_resources.each do |item|
      inventory = Inventory.create!(
        medical_resource_id: item.id,
        clinic_profile_id: clinic_specification_profile.id,
        amount: Faker::Number.between(from: 15, to: 30),
        price: Faker::Number.between(from: 5, to: 20)
      )
      inventories.push(inventory)
    end
  end

  def create_booking(hour, service, patient_specification_profile, clinic_specification_profile, status)
    start_time_raw = Time.zone.now  + 1.day
    start = start_time_raw.change({hour: hour, minute: 0})
    medical_record = MedicalRecord.new(patient_profile_id: patient_specification_profile.id, clinic_profile_id: clinic_specification_profile.id, start_time: start, end_time: start + service.execution_time.minutes, status: status)
    medical_record.save!
    examination_result = ExaminationResul.create!(medical_record_id: medical_record.id)
    service_item = ServiceItem.create!(medical_record_id: medical_record.id, service_id: service.id, price: 5.5)
  end

  clinic_specification_profiles.each do |clinic_specification_profile|
    create_booking(5, clinic_specification_profile.services[0], patient_specification_profile, clinic_specification_profile, 'finish')
    create_booking(5, clinic_specification_profile.services[0], patient_specification_profile1, clinic_specification_profile, "payment")
    create_booking(6, clinic_specification_profile.services[0], patient_specification_profile, clinic_specification_profile, 'finish')
    create_booking(6, clinic_specification_profile.services[0], patient_specification_profile1, clinic_specification_profile, "payment")
    create_booking(7, clinic_specification_profile.services[0], patient_specification_profile, clinic_specification_profile, 'finish')
    create_booking(7, clinic_specification_profile.services[0], patient_specification_profile1, clinic_specification_profile, "appointment")
    create_booking(8, clinic_specification_profile.services[0], patient_specification_profile, clinic_specification_profile, 'finish')
    create_booking(8, clinic_specification_profile.services[0], patient_specification_profile1, clinic_specification_profile, "appointment")
    create_booking(9, clinic_specification_profile.services[0], patient_specification_profile, clinic_specification_profile, 'finish')
    create_booking(9, clinic_specification_profile.services[0], patient_specification_profile1, clinic_specification_profile, "appointment")
    create_booking(10, clinic_specification_profile.services[0], patient_specification_profile, clinic_specification_profile, 'finish')
    create_booking(10, clinic_specification_profile.services[0], patient_specification_profile1, clinic_specification_profile, "appointment")

  end

  votes = []
  clinic_specification_profiles.each do |clinic_specification_profile|
    vote = Vote.create!(patient_profile_id: patient_specification_profile.id, clinic_profile_id: clinic_specification_profile.id, rate: Faker::Number.within(range: 1..5))
  end
end

