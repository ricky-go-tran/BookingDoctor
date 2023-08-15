require 'rails_helper'

RSpec.describe PrescriptionItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:amount) }
  end
end
