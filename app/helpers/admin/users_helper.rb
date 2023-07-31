# frozen_string_literal: true

module Admin
  module UsersHelper
    def get_role(user)
      if user.has_role?(:admin)
        'Admin'
      elsif user.has_role?(:basic)
        'Basic'
      else
        user.has_role?(:patient) ? 'Patient' : 'Clinic'
      end
    end
  end
end
