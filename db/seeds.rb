
ActiveRecord::Base.transaction do
  admin = User.create!(email: 'admin.study@gmail.com', password: '662001', confirmed_at: Time.current)
  admin.add_role :admin
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
  patient = User.create!(email: 'patient.study@gmail.com', password: '662001', confirmed_at: Time.current)
  patient.add_role :patient


  admin_profile =  Profile.create!(fullname: "Admin", birthday: '2023-07-25', address: '2023-07-25', user_id: admin.id)
  clinic_profile = Profile.create!(fullname: "Clinic", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic.id)
  clinic1_profile = Profile.create!(fullname: "Clinic1", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic1.id)
  clinic2_profile = Profile.create!(fullname: "Clinic2", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic2.id)
  clinic3_profile = Profile.create!(fullname: "Clinic3", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic3.id)
  patient_profile = Profile.create!(fullname: "Patient", birthday: '2023-07-25', address: '2023-07-25', user_id: patient.id)

  category_dental = Category.create!(name: "Dental Clinic", description: "A place dedicated to oral and dental care. Performs regular dental check-ups, dental treatments, tooth extractions, dental restorations, dental implants, and provides oral hygiene advice.")
  category_pediatric = Category.create!(name: "Pediatrics Clinic", description: "A place dedicated to oral and dental care. Performs regular dental check-ups, dental treatments, tooth extractions, dental restorations, dental implants, and provides oral hygiene advice.")
  category_dermatology = Category.create!(name: "Dermatology Clinic", description: "A place dedicated to oral and dental care. Performs regular dental check-ups, dental treatments, tooth extractions, dental restorations, dental implants, and provides oral hygiene advice.")

  clinic_specifi_profile = ClinicProfile.new(name: "Clinic Name", address: "Test1", profile_id: clinic_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile.save!
  clinic_specifi_profile1 = ClinicProfile.new(name: "Clinic Name1", address: "Test1", profile_id: clinic1_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile1.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile1.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile1.save!
  clinic_specifi_profile2 = ClinicProfile.new(name: "Clinic Name2", address: "Test1", profile_id: clinic2_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)

  clinic_specifi_profile2.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile2.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile2.save!
  clinic_specifi_profile3 = ClinicProfile.new(name: "Clinic Name3", address: "Test1", profile_id: clinic3_profile.id, description: "Test1", start_hour: "00:14:00", end_hour: "22:14:00", start_day: 0, end_day: 6, phone: "0123456789", category_id: category_dental.id)
  clinic_specifi_profile3.certificate.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile3.clinic_view.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  clinic_specifi_profile3.save!
  patient_specifi_profile = PatientProfile.create!(profile_id: patient_profile.id)

  service1 = Service.new(name: "Respiratory diseas", description: "Respiratory diseases services at Saigon Pediatric Clinic are one of the most specialized and focused areas. With a team of experienced and dedicated medical professionals, the hospital is committed to providing optimal diagnostic and treatment solutions for children's respiratory system problems.
    The Respiratory diseases service of Saigon Pediatric Clinic includes modern and advanced diagnostic methods to ensure accuracy and reliability. Doctors at the hospital will conduct a careful clinical examination, listen carefully to the symptoms, and conduct the necessary tests to determine the exact cause of the disease.", price: 4.5, execution_time: 30, clinic_profile_id: clinic_specifi_profile.id)

    service2 = Service.new(name: "Hepatitis B vacccine", description: "Respiratory diseases services at Saigon Pediatric Clinic are one of the most specialized and focused areas. With a team of experienced and dedicated medical professionals, the hospital is committed to providing optimal diagnostic and treatment solutions for children's respiratory system problems.
      The Respiratory diseases service of Saigon Pediatric Clinic includes modern and advanced diagnostic methods to ensure accuracy and reliability. Doctors at the hospital will conduct a careful clinical examination, listen carefully to the symptoms, and conduct the necessary tests to determine the exact cause of the disease.", price: 4.5, execution_time: 30, clinic_profile_id: clinic_specifi_profile.id)

  service3 = Service.new(name: "Diagnostic examination", description: "Respiratory diseases services at Saigon Pediatric Clinic are one of the most specialized and focused areas. With a team of experienced and dedicated medical professionals, the hospital is committed to providing optimal diagnostic and treatment solutions for children's respiratory system problems.
        The Respiratory diseases service of Saigon Pediatric Clinic includes modern and advanced diagnostic methods to ensure accuracy and reliability. Doctors at the hospital will conduct a careful clinical examination, listen carefully to the symptoms, and conduct the necessary tests to determine the exact cause of the disease.", price: 6, execution_time: 30, clinic_profile_id: clinic_specifi_profile1.id)

  service4 = Service.new(name: "Dental examination", description: "Respiratory diseases services at Saigon Pediatric Clinic are one of the most specialized and focused areas. With a team of experienced and dedicated medical professionals, the hospital is committed to providing optimal diagnostic and treatment solutions for children's respiratory system problems.
          The Respiratory diseases service of Saigon Pediatric Clinic includes modern and advanced diagnostic methods to ensure accuracy and reliability. Doctors at the hospital will conduct a careful clinical examination, listen carefully to the symptoms, and conduct the necessary tests to determine the exact cause of the disease.", price: 6, execution_time: 30, clinic_profile_id: clinic_specifi_profile2.id)
  service1.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  service2.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  service3.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  service4.service_wallpaper.attach(io: File.open(Rails.root.join('db/images/default.jpg')), filename: 'default.jpg')
  service1.save!
  service2.save!
  service3.save!
  service4.save!
  medical_resource = MedicalResource.create!(name: "BH Supplies 5ml Sterile Luer Lock Tip Syringes", brand: "DHG Pharma", unit: "PCS", description: "
    Luer lock connector: Plastic luer lock tip ensures tight seal rubber suitable for transferring tiny amounts of liquids and other materials
    Ideal for feeding pets: 5ml BH Supplies Sterile Luer Lock Tip Syringes are perfect for administering, refilling, and dispensing liquid supplements and medications to pets and livestock", medical_resource_type: "medicine")

    medical_resource1 = MedicalResource.create!(name: "Dolo (Paracetamol)  300", brand: "DHG Pharma", unit: "PCS", description: "
      Luer lock connector: Plastic luer lock tip ensures tight seal rubber suitable for transferring tiny amounts of liquids and other materials
      Ideal for feeding pets: 5ml BH Supplies Sterile Luer Lock Tip Syringes are perfect for administering, refilling, and dispensing liquid supplements and medications to pets and livestock", medical_resource_type: "medicine")

      medical_resource2 = MedicalResource.create!(name: "Ourdaily Vitamin C & Zinc Lemon", brand: "DHG Pharma", unit: "PCS", description: "
      Leak-free design: Individually wrapped and sealed syringes ensure leak-free construction for safe and reliable use in daily and scientific applications
      Ideal for feeding pets: 5ml BH Supplies Sterile Luer Lock Tip Syringes are perfect for administering, refilling, and dispensing liquid supplements and medications to pets and livestock", medical_resource_type: "medicine")

      medical_resource3 = MedicalResource.create!(name: "KLAMENTIN 500 150", brand: "DHG Pharma", unit: "PCS", description: "
      Leak-free design: Individually wrapped and sealed syringes ensure leak-free construction for safe and reliable use in daily and scientific applications
      Ideal for feeding pets: 5ml BH Supplies Sterile Luer Lock Tip Syringes are perfect for administering, refilling, and dispensing liquid supplements and medications to pets and livestock", medical_resource_type: "medicine")

  inventory = Inventory.create!(medical_resource_id: medical_resource.id, clinic_profile_id: clinic_specifi_profile.id, amount: 30, price: 1)
  inventory1 = Inventory.create!(medical_resource_id: medical_resource2.id, clinic_profile_id: clinic_specifi_profile.id, amount: 50, price: 1)
  inventory2 = Inventory.create!(medical_resource_id: medical_resource3.id, clinic_profile_id: clinic_specifi_profile.id, amount: 30, price: 1)
  inventory3 = Inventory.create!(medical_resource_id: medical_resource1.id, clinic_profile_id: clinic_specifi_profile.id, amount: 30, price: 1)

  inventory4 = Inventory.create!(medical_resource_id: medical_resource.id, clinic_profile_id: clinic_specifi_profile1.id, amount: 30, price: 1)
  inventory5 = Inventory.create!(medical_resource_id: medical_resource1.id, clinic_profile_id: clinic_specifi_profile1.id, amount: 30, price: 1)
  inventory6 = Inventory.create!(medical_resource_id: medical_resource2.id, clinic_profile_id: clinic_specifi_profile1.id, amount: 30, price: 1)
  inventory7 = Inventory.create!(medical_resource_id: medical_resource3.id, clinic_profile_id: clinic_specifi_profile1.id, amount: 30, price: 1)

  inventory8 = Inventory.create!(medical_resource_id: medical_resource.id, clinic_profile_id: clinic_specifi_profile2.id, amount: 30, price: 1)
  inventory9 = Inventory.create!(medical_resource_id: medical_resource1.id, clinic_profile_id: clinic_specifi_profile2.id, amount: 30, price: 1)
  inventory10 = Inventory.create!(medical_resource_id: medical_resource2.id, clinic_profile_id: clinic_specifi_profile2.id, amount: 30, price: 1)
  inventory11 = Inventory.create!(medical_resource_id: medical_resource3.id, clinic_profile_id: clinic_specifi_profile2.id, amount: 30, price: 1)

  # vote  = Vote.create!(clinic_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile.id, rate: 5, comment: "Good");


  medical_record = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile.id, start_time: Time.now+ 4.hour, end_time: Time.now, status: "finish")
  medical_record1 = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile1.id, start_time: Time.now+ 4.hour, end_time: Time.now , status: "finish")
  medical_record2 = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile2.id, start_time: Time.now+ 4.hour, end_time: Time.now, status: "finish")
  medical_record3 = MedicalRecord.create!(patient_profile_id: patient_specifi_profile.id, clinic_profile_id: clinic_specifi_profile3.id, start_time: Time.now+ 4.hour, end_time: Time.now, status: "finish")

  examination_result = ExaminationResul.create!(medical_record_id: medical_record.id)
  examination_result1 = ExaminationResul.create!(medical_record_id: medical_record1.id)
  examination_result2 = ExaminationResul.create!(medical_record_id: medical_record2.id)
  examination_result3 = ExaminationResul.create!(medical_record_id: medical_record3.id)

  service_item = ServiceItem.create!(medical_record_id: medical_record.id, service_id: service1.id, price: 5.5)
  service_item1 = ServiceItem.create!(medical_record_id: medical_record1.id, service_id: service1.id, price: 5.5)
  service_item2 = ServiceItem.create!(medical_record_id: medical_record2.id, service_id: service1.id, price: 5.5)
  service_item3 = ServiceItem.create!(medical_record_id: medical_record3.id, service_id: service1.id, price: 5.5)


end

