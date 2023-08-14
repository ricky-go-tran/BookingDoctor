require 'rails_helper'

RSpec.describe ClinicProfile, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_day) }
    it { should validate_presence_of(:end_day) }
    it { should validate_presence_of(:start_hour) }
    it { should validate_presence_of(:end_hour) }
  end
end
