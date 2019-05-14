require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'auth_token' do
    it 'generates an auth token' do
      user = FactoryBot.create(:user)
      expect(user.auth_token).to be_present
    end
  end
end
