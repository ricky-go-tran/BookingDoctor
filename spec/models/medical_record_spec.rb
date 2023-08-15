require 'rails_helper'

RSpec.describe MedicalRecord, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end
end
