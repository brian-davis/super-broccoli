# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  client_name :string(255)      not null
#  auth_token  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:shortlinks).dependent(:destroy) }
    it { should have_many(:clicks).through(:shortlinks) }
  end

  describe 'auth_token' do
    it 'generates an auth token' do
      user = FactoryBot.create(:user)
      expect(user.auth_token).to be_present
    end
  end
end
