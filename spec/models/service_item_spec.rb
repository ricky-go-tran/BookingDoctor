require 'rails_helper'

RSpec.describe ServiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:price) }
  end
end
