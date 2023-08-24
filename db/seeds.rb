# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = User.create!(email: 'admin.study@gmail.com', password: '662001', confirmed_at: Time.current)
admin.add_role :admin
clinic = User.create!(email: 'clinic.study@gmail.com', password: '662001', confirmed_at: Time.current)
clinic.add_role :clinic
patient = User.create!(email: 'patient.study@gmail.com', password: '662001', confirmed_at: Time.current)
patient.add_role :patient


admin_profile =  Profile.create!(fullname: "Admin", birthday: '2023-07-25', address: '2023-07-25', user_id: admin.id)
clinic_profile = Profile.create!(fullname: "Clinic", birthday: '2023-07-25', address: '2023-07-25', user_id: clinic.id)
patient_profile = Profile.create!(fullname: "Patient", birthday: '2023-07-25', address: '2023-07-25', user_id: patient.id)

clinic_specifi_profile = ClinicProfile.create!(name: "Clinic Name", address: "Test", profile_id: clinic_profile.id, description: "Test", start_hour: "02:14:00", end_hour: "10:14:00", start_day: 1, end_day: 5, phone: "123456789", category_id: 1)
patient_specifi_profile = PatientProfile.create!(profile_id: patient_profile.id)
