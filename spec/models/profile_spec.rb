require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:fullname) }
  end
end
