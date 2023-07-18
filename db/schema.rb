# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_18_083043) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinic_profiles", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.text "address", null: false
    t.string "phone", null: false
    t.text "description", null: false
    t.integer "start_hour", null: false
    t.integer "end_hour", null: false
    t.integer "start_day", null: false
    t.integer "end_day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_clinic_profiles_on_category_id"
    t.index ["profile_id"], name: "index_clinic_profiles_on_profile_id"
  end

  create_table "consumptions", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "medical_resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_resource_id"], name: "index_consumptions_on_medical_resource_id"
    t.index ["service_id"], name: "index_consumptions_on_service_id"
  end

  create_table "examination_resuls", force: :cascade do |t|
    t.bigint "medical_record_id", null: false
    t.float "body_temp"
    t.integer "heart_rate"
    t.integer "blood_pressure"
    t.text "desciption"
    t.text "conslusion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_record_id"], name: "index_examination_resuls_on_medical_record_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.bigint "medical_resource_id", null: false
    t.bigint "clinic_profile_id", null: false
    t.integer "amount", null: false
    t.float "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_profile_id"], name: "index_inventories_on_clinic_profile_id"
    t.index ["medical_resource_id"], name: "index_inventories_on_medical_resource_id"
  end

  create_table "medical_records", force: :cascade do |t|
    t.bigint "patient_profile_id", null: false
    t.bigint "clinic_profile_id", null: false
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.string "status", default: "appointment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_profile_id"], name: "index_medical_records_on_clinic_profile_id"
    t.index ["patient_profile_id"], name: "index_medical_records_on_patient_profile_id"
  end

  create_table "medical_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "brand", null: false
    t.string "unit", null: false
    t.text "description", null: false
    t.string "type", default: "medicine", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_profiles", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.float "height"
    t.float "weight"
    t.string "blood_group"
    t.text "drug_allergy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_patient_profiles_on_profile_id"
  end

  create_table "prescription_items", force: :cascade do |t|
    t.bigint "medical_record_id", null: false
    t.bigint "medical_resource_id", null: false
    t.integer "amount"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_record_id"], name: "index_prescription_items_on_medical_record_id"
    t.index ["medical_resource_id"], name: "index_prescription_items_on_medical_resource_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "fullname"
    t.date "birthday"
    t.text "address"
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.string "content", null: false
    t.string "type", default: "system_prolem", null: false
    t.string "status", default: "unprocess", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "service_items", force: :cascade do |t|
    t.bigint "medical_record_id", null: false
    t.bigint "service_id", null: false
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_record_id"], name: "index_service_items_on_medical_record_id"
    t.index ["service_id"], name: "index_service_items_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "clinic_profile_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.float "price", null: false
    t.integer "execution_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_profile_id"], name: "index_services_on_clinic_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "clinic_profile_id", null: false
    t.bigint "patient_profile_id", null: false
    t.integer "rate", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_profile_id"], name: "index_votes_on_clinic_profile_id"
    t.index ["patient_profile_id"], name: "index_votes_on_patient_profile_id"
  end

  add_foreign_key "clinic_profiles", "categories"
  add_foreign_key "clinic_profiles", "profiles"
  add_foreign_key "consumptions", "medical_resources"
  add_foreign_key "consumptions", "services"
  add_foreign_key "examination_resuls", "medical_records"
  add_foreign_key "inventories", "clinic_profiles"
  add_foreign_key "inventories", "medical_resources"
  add_foreign_key "medical_records", "clinic_profiles"
  add_foreign_key "medical_records", "patient_profiles"
  add_foreign_key "patient_profiles", "profiles"
  add_foreign_key "prescription_items", "medical_records"
  add_foreign_key "prescription_items", "medical_resources"
  add_foreign_key "reports", "users"
  add_foreign_key "service_items", "medical_records"
  add_foreign_key "service_items", "services"
  add_foreign_key "services", "clinic_profiles"
  add_foreign_key "votes", "clinic_profiles"
  add_foreign_key "votes", "patient_profiles"
end
