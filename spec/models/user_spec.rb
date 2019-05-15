# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:shortlinks) }
  end

  describe 'auth_token' do
    it 'generates an auth token' do
      user = FactoryBot.create(:user)
      expect(user.auth_token).to be_present
    end
  end
end
