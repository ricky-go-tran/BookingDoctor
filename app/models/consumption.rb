class Consumption < ApplicationRecord
  belongs_to :service
  belongs_to :medical_resource
end
