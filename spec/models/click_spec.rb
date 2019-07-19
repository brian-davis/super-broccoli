# frozen_string_literal:true

# == Schema Information
#
# Table name: clicks
#
#  id           :bigint           not null, primary key
#  shortlink_id :bigint
#  ip_address   :string(255)
#  user_agent   :string(255)
#  referer      :string(255)
#  device       :string(255)
#  browser      :string(255)
#  location     :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#


require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'attributes' do
    it { should have_db_column(:id) }
    it { should have_db_column(:shortlink_id) }
    it { should have_db_column(:ip_address) }
    it { should have_db_column(:user_agent) }
    it { should have_db_column(:referer) }
    it { should have_db_column(:device) }
    it { should have_db_column(:browser) }
    it { should have_db_column(:location) }
  end

  describe 'associations' do
    it { should belong_to(:shortlink).counter_cache(:click_count) }
  end

  describe 'scopes' do
  end
end
