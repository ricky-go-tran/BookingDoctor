# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :report
  has_one :profile
  scope :search, ->(query) {
                   where(id: Profile.select(:user_id)
                   .where('UPPER(fullname) LIKE UPPER(?)', "%#{query}%")).or(User
                     .where('UPPER(email ) LIKE UPPER(?)', "%#{query}%"))
                 }
  before_create do
    if email == 'tdphat.study@gmail.com'
      add_role(:admin)
    else
      add_role(:patient)
    end
  end

  def delete_roles
    roles.delete(roles.where(id: roles.ids))
  end

  def get_profile
    profile
  end

  def get_profile_clinic
    profile.clinic_profile
  end

  def get_profile_patient
    profile.patient_profile
  end
end
