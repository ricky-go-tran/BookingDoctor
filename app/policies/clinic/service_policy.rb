class Clinic::ServicePolicy < ApplicationPolicy
  def show?
    user.profile.clinic_profile.id == record.clinic_profile_id
  end

  def edit?
    user.profile.clinic_profile.id == record.clinic_profile_id
  end

  def destroy?
    user.profile.clinic_profile.id == record.clinic_profile_id
  end

  def update?
    user.profile.clinic_profile.id == record.clinic_profile_id
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
