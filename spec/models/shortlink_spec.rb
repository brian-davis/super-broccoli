# frozen_string_literal:true

# == Schema Information
#
# Table name: shortlinks
#
#  id          :bigint           not null, primary key
#  source      :text(65535)      not null
#  slug        :string(255)      not null
#  click_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default("active"), not null
#  user_id     :bigint
#

require 'rails_helper'

RSpec.describe Shortlink, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:clicks).dependent(:destroy) }

    describe 'counter cahce' do
      let(:shortlink) { FactoryBot.create(:shortlink) }

      it 'increments click_count' do
        expect { shortlink.clicks.create }.to change { shortlink.click_count }.from(0).to(1)
      end
    end
  end

  describe 'validations' do
    describe 'source' do
      it { should validate_presence_of(:source) }

      it 'is unique scoped to user' do
        user1 = FactoryBot.create(:user, client_name: 'idlife')
        user2 = FactoryBot.create(:user, client_name: 'tupperware')

        existing_shortlink = FactoryBot.create(:shortlink, user: user1)

        subject1_options = { source: existing_shortlink.source, user: user1 }
        subject1 = FactoryBot.build(:shortlink, subject1_options)

        expect(subject1).not_to be_valid
        expect('has already been taken').to(
          be_in(subject1.errors.messages[:source])
        )

        subject2_options = { source: existing_shortlink.source, user: user2 }
        subject2 = FactoryBot.build(:shortlink, subject2_options)
        expect(subject2).to be_valid
      end

      describe 'format' do
        context 'valid' do
          it 'accepts valid shortlinks' do
            expect(FactoryBot.build(:shortlink)).to be_valid
          end
        end

        context 'invalid' do
          it 'rejects invalid shortlinks' do
            link = FactoryBot.build(:shortlink, { source: 'gttp://ww.wrong' })
            expect(link).not_to be_valid
          end

          it 'avoids URI class bug' do
            link = FactoryBot.build(:shortlink, { source: 'https://' })
            expect(link).not_to be_valid
          end
        end
      end
    end

    describe 'slug' do
      it 'will set a unique value before create' do
        shortlink = FactoryBot.build(:shortlink)
        expect(shortlink.slug).to be_nil
        shortlink.save
        shortlink.reload
        expect(shortlink.slug).to match(/[a-zA-Z0-9\-_]{6}/)
      end

      it 'will only set a new slug for new records' do
        shortlink = FactoryBot.create(:shortlink)
        before = shortlink.slug
        shortlink.save
        shortlink.reload
        after = shortlink.slug
        expect(after).to eq(before)
      end
    end

    describe 'status' do
      let(:subject1) { FactoryBot.create(:shortlink, { status: :active }) }
      let(:subject2) { FactoryBot.create(:shortlink, { status: :expired }) }

      it 'can be active' do
        expect(subject1).to be_active
        expect(subject2).not_to be_active
      end

      it 'can be expired' do
        expect(subject2).to be_expired
        expect(subject1).not_to be_expired
      end

      it 'is active by default' do
        subject3 = FactoryBot.build(:shortlink)
        expect(subject3).to be_active
      end

      describe 'scopes' do
        it 'scopes active' do
          expect(subject1).to be_in(described_class.active)
          expect(subject2).not_to be_in(described_class.active)
        end

        it 'scopes expired' do
          expect(subject2).to be_in(described_class.expired)
          expect(subject1).not_to be_in(described_class.expired)
        end
      end
    end

    describe 'scopes' do
      it 'scopes records ready to expire in a cron rake task' do
        subject1 = FactoryBot.create(:shortlink) # status :active
        subject1.update_attributes({ created_at: 100.days.ago })
        subject2 = FactoryBot.create(:shortlink) # status :active

        expect(subject1).to be_in(described_class.expire_ready)
        expect(subject2).not_to be_in(described_class.expire_ready)
      end

      it 'excludes already-exired records' do
        subject1 = FactoryBot.create(:shortlink, { status: :expired })
        subject1.update_attributes({ created_at: 100.days.ago })
        expect(subject1).not_to be_in(described_class.expire_ready)
      end
    end
  end
end
