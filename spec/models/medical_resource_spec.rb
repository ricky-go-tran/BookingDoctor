require 'rails_helper'

RSpec.describe MedicalResource, type: :model do
  describe 'validations' do
    subject { create(:medical_resource) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:medical_resource_type) }
  end
end
