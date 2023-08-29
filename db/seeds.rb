
ActiveRecord::Base.transaction do
  # Create role admin
  admin = User.create!(email: 'admin.study@gmail.com', password: '662001', confirmed_at: Time.current)
  admin.add_role :admin
  admin1 = User.create!(email: 'admin1.study@gmail.com', password: '662001', confirmed_at: Time.current)
  admin1.add_role :admin

  # Create clinic
  clinic = User.create!(email: 'clinic.study@gmail.com', password: '662001', confirmed_at: Time.current)
  clinic.delete_roles
  clinic.add_role :clinic
  clinic1 = User.create!(email: 'clinic1.study@gmail.com', password: '662001', confirmed_at: Time.current)
  clinic1.delete_roles
  clinic1.add_role :clinic
  clinic2 = User.create!(email: 'clinic2.study@gmail.com', password: '662001', confirmed_at: Time.current)
  clinic2.delete_roles
  clinic2.add_role :clinic
  clinic3 = User.create!(email: 'clinic3.study@gmail.com', password: '662001', confirmed_at: Time.current)
  clinic3.delete_roles
  clinic3.add_role :clinic
  clinic4 = User.create!(email: 'ricky.tran.goldenowl@gmail.com', password: '662001', confirmed_at: Time.current)
  clinic4.delete_roles
  clinic4.add_role :clinic

  patient = User.create!(email: 'patient.study@gmail.com', password: '662001', confirmed_at: Time.current)
  patient.add_role :patient
  patient1 = User.create!(email: 'trandaiphat046@gmail.com', password: '662001', confirmed_at: Time.current)
  patient1.add_role :patient

  admin_profile =  Profile.create!(fullname: "Admin", birthday: '2023-07-25', address: '2023-07-25', user_id: admin.id)
  clinic_profile = Profile.create!(fullname: "Clinic", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic.id)
  clinic1_profile = Profile.create!(fullname: "SaiGon Clinic", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic1.id)
  clinic2_profile = Profile.create!(fullname: "CanTho Clinic", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic2.id)
  clinic3_profile = Profile.create!(fullname: "HungVuong Clinic", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic3.id)
  clinic4_profile = Profile.create!(fullname: "HungVuong Clinic", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic4.id)

  patient_profile = Profile.create!(fullname: "Patient", birthday: '2023-07-25', address: '2023-07-25', user_id: patient.id)
  patient_profile1 = Profile.create!(fullname: "Patient1", birthday: '2023-07-25', address: '2023-07-25', user_id: patient1.id)
  category_dental = Category.create!(name: "Dental Clinic", description: "A place dedicated to oral and dental care. Performs regular dental check-ups, dental treatments, tooth extractions, dental restorations, dental implants, and provides oral hygiene advice.")
  category_pediatric = Category.create!(name: "Pediatrics Clinic", description: "A place dedicated to oral and dental care. Performs regular dental check-ups, dental treatments, tooth extractions, dental restorations, dental implants, and provides oral hygiene advice.")
  category_dermatology = Category.create!(name: "Dermatology Clinic", description: "A place dedicated to oral and dental care. Performs regular dental check-ups, dental treatments, tooth extractions, dental restorations, dental implants, and provides oral hygiene advice.")
  clinic_specifi_profile = ClinicProfile.new(name: "Clinic", address: "Test1", profile_id: clinic_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile.save!
  clinic_specifi_profile1 = ClinicProfile.new(name: "SaiGon Clinic", address: "Test1", profile_id: clinic1_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile1.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile1.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile1.save!
  clinic_specifi_profile2 = ClinicProfile.new(name: "CanTho Clinic", address: "Test1", profile_id: clinic2_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile2.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile2.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile2.save!
  clinic_specifi_profile3 = ClinicProfile.new(name: "HungVuong Clinic", address: "Test1", profile_id: clinic3_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile3.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile3.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile3.save!
  clinic_specifi_profile4 = ClinicProfile.new(name: "An Duong Vuong Clinic", address: "Test1", profile_id: clinic4_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile4.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile4.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile4.save!

  patient_specifi_profile = PatientProfile.create!(profile_id: patient_profile.id)
  patient_specifi_profile1 = PatientProfile.create!(profile_id: patient_profile1.id)
  Faker::Lorem.sentence

  service_clinic = []
  8.times do
    service = Service.new(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10) , price: Faker::Number.within(range: 1..5), execution_time: Faker::Number.within(range: 15..30), clinic_profile_id: clinic_specifi_profile.id)
    service.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
    service.save!
    service_clinic.push(service)
  end

  service_clinic1 = []
  8.times do
    service = Service.new(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10) , price: Faker::Number.within(range: 1..5), execution_time: Faker::Number.within(range: 15..30), clinic_profile_id: clinic_specifi_profile1.id)
    service.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
    service.save!
    service_clinic1.push(service)
  end

  service_clinic2 = []
  8.times do
    service = Service.new(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10) , price: Faker::Number.within(range: 1..5), execution_time: Faker::Number.within(range: 15..30), clinic_profile_id: clinic_specifi_profile2.id)
    service.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
    service.save!
    service_clinic2.push(service)
  end

  service_clinic3 = []
  8.times do
    service = Service.new(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10) , price: Faker::Number.within(range: 1..5), execution_time: Faker::Number.within(range: 15..30), clinic_profile_id: clinic_specifi_profile3.id)
    service.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
    service.save!
    service_clinic3.push(service)
  end

  service_clinic4 = []
  8.times do
    service = Service.new(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(sentence_count: 10) , price: Faker::Number.within(range: 1..5), execution_time: Faker::Number.within(range: 15..30), clinic_profile_id: clinic_specifi_profile4.id)
    service.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
    service.save!
    service_clinic4.push(service)
  end

  medical_resources = []
  15.times do
    medical_resource = MedicalResource.create!(name:  Faker::Lorem.sentence, brand: Faker::Lorem.sentence, unit: "PCS", description: Faker::Lorem.paragraph(sentence_count: 10), medical_resource_type: "medicine")
    medical_resources.push(medical_resource)
  end


  inventories = []
  medical_resources.each do |item|
    inventory = Inventory.create!(
      medical_resource_id: item.id,
      clinic_profile_id: clinic_specifi_profile.id,
      amount: Faker::Number.between(from: 15, to: 30),
      price: Faker::Number.between(from: 5, to: 20)
    )
    inventories.push(inventory)
  end

  inventories1 = []
  medical_resources.each do |item|
    inventory = Inventory.create!(
      medical_resource_id: item.id,
      clinic_profile_id: clinic_specifi_profile1.id,
      amount: Faker::Number.between(from: 15, to: 30),
      price: Faker::Number.between(from: 5, to: 20)
    )
    inventories1.push(inventory)
  end

  inventories2 = []
  medical_resources.each do |item|
    inventory = Inventory.create!(
      medical_resource_id: item.id,
      clinic_profile_id: clinic_specifi_profile2.id,
      amount: Faker::Number.between(from: 15, to: 30),
      price: Faker::Number.between(from: 5, to: 20)
    )
    inventories2.push(inventory)
  end

  inventories3 = []
  medical_resources.each do |item|
    inventory = Inventory.create!(
      medical_resource_id: item.id,
      clinic_profile_id: clinic_specifi_profile3.id,
      amount: Faker::Number.between(from: 15, to: 30),
      price: Faker::Number.between(from: 5, to: 20)
    )
    inventories3.push(inventory)
  end

  inventories4 = []
  medical_resources.each do |item|
    inventory = Inventory.create!(
      medical_resource_id: item.id,
      clinic_profile_id: clinic_specifi_profile4.id,
      amount: Faker::Number.between(from: 15, to: 30),
      price: Faker::Number.between(from: 5, to: 20)
    )
    inventories4.push(inventory)
  end

  medical_record = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile.id, start_time: Time.now+ 4.hour, end_time: Time.now, status: "appointment")
  medical_record1 = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile1.id, start_time: Time.now+ 4.hour, end_time: Time.now , status: "appointment")
  medical_record2 = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile2.id, start_time: Time.now+ 4.hour, end_time: Time.now, status: "appointment")
  medical_record3 = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile3.id, start_time: Time.now+ 4.hour, end_time: Time.now, status: "appointment")

  examination_result = ExaminationResul.create!(medical_record_id: medical_record.id)
  examination_result1 = ExaminationResul.create!(medical_record_id: medical_record1.id)
  examination_result2 = ExaminationResul.create!(medical_record_id: medical_record2.id)
  examination_result3 = ExaminationResul.create!(medical_record_id: medical_record3.id)

  service_item = ServiceItem.create!(medical_record_id: medical_record.id, service_id: service1.id, price: 5.5)
  service_item1 = ServiceItem.create!(medical_record_id: medical_record1.id, service_id: service1.id, price: 5.5)
  service_item2 = ServiceItem.create!(medical_record_id: medical_record2.id, service_id: service1.id, price: 5.5)
  service_item3 = ServiceItem.create!(medical_record_id: medical_record3.id, service_id: service1.id, price: 5.5)
end

