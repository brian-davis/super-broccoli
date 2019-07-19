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
#  device       :integer
#  browser      :integer
#  location     :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  platform     :integer
#


require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'attributes' do
    it { should have_db_column(:id) }
    it { should have_db_column(:shortlink_id) }
    it { should have_db_column(:ip_address) }
    it { should have_db_column(:user_agent) }
    it { should have_db_column(:referer) }
    it { should have_db_column(:device).of_type(:integer) }
    it { should have_db_column(:browser).of_type(:integer) }
    it { should have_db_column(:platform).of_type(:integer) }
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
    describe 'time based' do
      let!(:shortlink) { FactoryBot.create(:shortlink) }

      let!(:today_click) { shortlink.clicks.create }

      let!(:this_week_click) do
        c = shortlink.clicks.create
        c.update_attributes(created_at: 2.days.ago)
        c
      end

      let!(:this_month_click) do
        c = shortlink.clicks.create
        c.update_attributes(created_at: 2.weeks.ago)
        c
      end

      let!(:old_click) do
        c = shortlink.clicks.create
        c.update_attributes(created_at: 2.months.ago)
        c
      end

      describe 'last 24 hours' do
        it 'queries created_at' do
          scope = described_class.last_24_hours
          expect(today_click).to be_in(scope)
          expect(this_week_click).not_to be_in(scope)
          expect(this_month_click).not_to be_in(scope)
          expect(old_click).not_to be_in(scope)
        end
      end

      describe 'last 7 days' do
        it 'queries created_at' do
          scope = described_class.last_7_days
          expect(today_click).to be_in(scope)
          expect(this_week_click).to be_in(scope)
          expect(this_month_click).not_to be_in(scope)
          expect(old_click).not_to be_in(scope)
        end
      end

      describe 'last 30 days' do
        it 'queries created_at' do
          scope = described_class.last_30_days
          expect(today_click).to be_in(scope)
          expect(this_week_click).to be_in(scope)
          expect(this_month_click).to be_in(scope)
          expect(old_click).not_to be_in(scope)
        end
      end
    end

    describe 'enums' do
      let!(:shortlink) { FactoryBot.create(:shortlink) }
      let!(:ios_click) {
        shortlink.clicks.create({
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 12_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1.1 Mobile/15E148 Safari/604.1'
        })
      }
      let!(:desktop_click) {
        shortlink.clicks.create({
          user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36'
        })
      }

      it 'queries device enum scopes' do
        expect(ios_click).to be_in(described_class.iphone)
        expect(ios_click).to be_in(described_class.mobile)

        expect(desktop_click).not_to be_in(described_class.iphone)
        expect(ios_click).not_to be_in(described_class.tv)
      end

      it 'queries browser enum scopes' do
        # browser
        expect(ios_click).to be_in(described_class.safari)
        expect(ios_click).not_to be_in(described_class.chrome)

        expect(desktop_click).to be_in(described_class.chrome)
        expect(desktop_click).not_to be_in(described_class.safari)
      end

      it 'queries platform enum scopes' do
        # platform
        expect(ios_click).to be_in(described_class.ios)
        expect(desktop_click).not_to be_in(described_class.ios)

        expect(ios_click).not_to be_in(described_class.linux)
        expect(desktop_click).to be_in(described_class.linux)

        expect(ios_click).not_to be_in(described_class.desktop)
        expect(desktop_click).to be_in(described_class.desktop)

        expect(ios_click).to be_in(described_class.mobile)
        expect(desktop_click).not_to be_in(described_class.mobile)
      end
    end
  end

  describe 'callbacks' do
    context(:mobile) do
      let(:user_agent) do
        'Mozilla/5.0 (iPhone; CPU iPhone OS 12_3_1 like Mac OS X) AppleWebKit/605.1.15 ' \
        '(KHTML, like Gecko) Version/12.1.1 Mobile/15E148 Safari/604.1'
      end

      let!(:shortlink) { FactoryBot.create(:shortlink) }
      let!(:click) { shortlink.clicks.create({ user_agent: user_agent }) }

      it 'sets the browser before create' do
        expect(click.browser).to eq('safari')
      end

      it 'sets the device before create' do
        expect(click.device).to eq('iphone')
      end

      it 'sets the platform before create' do
        expect(click.platform).to eq('ios')
      end
    end

    context(:blackberry) do
      let(:user_agent) do
        'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.10+ (KHTML, like Gecko)' \
        ' Version/10.0.9.1675 Mobile Safari/537.10+'
      end

      let!(:shortlink) { FactoryBot.create(:shortlink) }
      let!(:click) { shortlink.clicks.create({ user_agent: user_agent }) }

      it 'sets the browser before create, with enum name override' do
        expect(click.browser).to eq('blackberry_browser')
      end

      it 'sets the device before create' do
        expect(click.device).to eq('unknown')
      end

      it 'sets the platform before create' do
        expect(click.platform).to eq('blackberry')
      end
    end

    context(:desktop) do
      let(:user_agent) do
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) ' \
        'Chrome/72.0.3626.121 Safari/537.36'
      end

      let!(:shortlink) { FactoryBot.create(:shortlink) }
      let!(:click) { shortlink.clicks.create({ user_agent: user_agent }) }

      it 'sets the browser before create' do
        expect(click.browser).to eq('chrome')
      end

      it 'sets the device before create' do
        expect(click.device).to eq('unknown')
      end

      it 'sets the platform before create' do
        expect(click.platform).to eq('linux')
      end
    end
  end
end
