# frozen_string_literal: true

class PatientProfile < ApplicationRecord
  belongs_to :profile
  has_many :medical_records
  has_many :votes
  has_many :clinic_profiles, through: :votes
  resourcify
  before_validation :create_on_stripe, on: :create

  enum blood_group: { A_Positive: 'A+', A_Negative: 'A-', B_Positive: 'B+', B_Negative: 'B-',
                      O_Positive: 'O+', O_Negative: 'O-', AB_Negative: 'AB-', AB_Positive: 'AB+' }

  scope :get_patients_of_clinics, ->(id) {
    joins(:medical_records).where('medical_records.clinic_profile_id = ?', id).group('patient_profiles.id')
  }

  def create_on_stripe
    user = User.find_by(id: Profile.find_by(id: profile_id).user_id)
    params = { email: user.email, name: user.profile.fullname }
    response = Stripe::Customer.create(params)
    self.stripe_id = response.id
  end
end
