class Categoty < ApplicationRecord
  has_many :clinic_profiles
  resourcify
end
