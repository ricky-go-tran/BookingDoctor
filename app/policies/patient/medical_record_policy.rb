class Patient::MedicalRecordPolicy < ApplicationPolicy
  def show?
    user.profile.patient_profile.id == record.patient_profile_id
  end

  def cancle?
    user.profile.patient_profile.id == record.patient_profile_id
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
