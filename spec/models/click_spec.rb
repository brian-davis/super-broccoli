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

    describe 'user agent inspector' do
      let(:user_agent) do
        'Mozilla/5.0 (iPhone; CPU iPhone OS 12_3_1 like Mac OS X) AppleWebKit/605.1.15 ' \
        '(KHTML, like Gecko) Version/12.1.1 Mobile/15E148 Safari/604.1'
      end

      it 'returns a browser gem object which parses the user_agent string' do
        subject = described_class.new(user_agent: user_agent)
        expect(subject.user_agent_inspector).to be_a(Browser::Base) # Browser::Safari
      end
    end
  end

  describe 'scopes' do
  end

  describe 'callbacks' do
    context(:mobile) do
      let(:user_agent) do
        'Mozilla/5.0 (iPhone; CPU iPhone OS 12_3_1 like Mac OS X) AppleWebKit/605.1.15 ' \
        '(KHTML, like Gecko) Version/12.1.1 Mobile/15E148 Safari/604.1'
      end

      let(:shortlink) { FactoryBot.create(:shortlink) }

      it 'sets the browser before create' do
        c = shortlink.clicks.create({ user_agent: user_agent })
        expect(c.browser).to eq('Safari')
      end

      it 'sets the device before create' do
        c = shortlink.clicks.create({ user_agent: user_agent })
        expect(c.device).to eq('iPhone')
      end
    end

    context(:desktop) do
      let(:user_agent) do
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) ' \
        'Chrome/72.0.3626.121 Safari/537.36'
      end

      let(:shortlink) { FactoryBot.create(:shortlink) }

      it 'sets the browser before create' do
        c = shortlink.clicks.create({ user_agent: user_agent })
        expect(c.browser).to eq('Chrome')
      end

      it 'sets the device before create' do
        c = shortlink.clicks.create({ user_agent: user_agent })
        expect(c.device).to eq('Desktop')
      end
    end
  end
end
