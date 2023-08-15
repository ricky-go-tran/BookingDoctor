# frozen_string_literal: true

module HomepagesHelper
  def get_day_in_week(day)
    ClinicProfile.days.key(day).camelize
  end

  def get_fullname_by_id_patient_profile(patient_id)
    PatientProfile.find_by(id: patient_id).profile.fullname
  end

  def is_patient?
    user_signed_in? && !current_user.profile.nil? && current_user.has_role?(:patient) && current_user.profile.status == 'valid'
  end
end
